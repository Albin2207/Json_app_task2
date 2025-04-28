import 'package:flutter_test/flutter_test.dart';
import 'package:json_app/api_service/notification_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'notification_service_test.mocks.dart';

// Generate mock class
@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ApiService apiService;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(
      client: mockClient,
    ); // Now we can pass the mock client
  });

  group('ApiService', () {
    test(
      'fetchNotifications returns a NotificationResponse if the http call completes successfully',
      () async {
        // Arrange
        final responseJson = '''
      {
        "message": "Notification listed successfully",
        "data": [
          {
            "image": "order_delivered.png",
            "title": "Order Delivered",
            "body": "Your order containing 2 items has been delivered.",
            "timestamp": "2023-01-10T11:06:54.754"
          }
        ]
      }
      ''';

        when(
          mockClient.get(Uri.parse(ApiService.notificationEndpoint)),
        ).thenAnswer((_) async => http.Response(responseJson, 200));

        // Act
        final response = await apiService.fetchNotifications();

        // Assert
        expect(response.message, 'Notification listed successfully');
        expect(response.data.length, 1);
        expect(response.data[0].title, 'Order Delivered');
      },
    );

    test(
      'fetchNotifications throws an exception if the http call completes with an error',
      () async {
        // Arrange
        when(
          mockClient.get(Uri.parse(ApiService.notificationEndpoint)),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(apiService.fetchNotifications(), throwsException);
      },
    );

    // You can add similar tests for fetchNotificationsWithIsolate
  });
}
