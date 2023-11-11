```php
<?php

namespace Tests\Unit;

use App\Models\Notification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NotificationTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test notification creation.
     *
     * @return void
     */
    public function testNotificationCreation()
    {
        $notification = Notification::factory()->create();

        $this->assertDatabaseHas('notifications', ['id' => $notification->id]);
    }

    /**
     * Test notification update.
     *
     * @return void
     */
    public function testNotificationUpdate()
    {
        $notification = Notification::factory()->create();
        $notification->update(['message' => 'New Notification Message']);

        $this->assertDatabaseHas('notifications', ['id' => $notification->id, 'message' => 'New Notification Message']);
    }

    /**
     * Test notification deletion.
     *
     * @return void
     */
    public function testNotificationDeletion()
    {
        $notification = Notification::factory()->create();
        $notification->delete();

        $this->assertDatabaseMissing('notifications', ['id' => $notification->id]);
    }
}
```