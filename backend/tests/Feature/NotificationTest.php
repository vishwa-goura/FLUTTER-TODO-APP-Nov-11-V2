```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\Notification;
use App\Models\User;

class NotificationTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test if a notification can be created.
     *
     * @return void
     */
    public function testNotificationCanBeCreated()
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->post('/api/notifications', [
            'title' => 'Test Notification',
            'body' => 'This is a test notification.',
            'user_id' => $user->id
        ]);

        $response->assertStatus(201);
        $this->assertCount(1, Notification::all());
    }

    /**
     * Test if a notification can be updated.
     *
     * @return void
     */
    public function testNotificationCanBeUpdated()
    {
        $user = User::factory()->create();
        $notification = Notification::factory()->create(['user_id' => $user->id]);

        $response = $this->actingAs($user)->put('/api/notifications/' . $notification->id, [
            'title' => 'Updated Test Notification',
            'body' => 'This is an updated test notification.',
        ]);

        $response->assertStatus(200);
        $this->assertEquals('Updated Test Notification', $notification->fresh()->title);
    }

    /**
     * Test if a notification can be deleted.
     *
     * @return void
     */
    public function testNotificationCanBeDeleted()
    {
        $user = User::factory()->create();
        $notification = Notification::factory()->create(['user_id' => $user->id]);

        $response = $this->actingAs($user)->delete('/api/notifications/' . $notification->id);

        $response->assertStatus(204);
        $this->assertCount(0, Notification::all());
    }
}
```