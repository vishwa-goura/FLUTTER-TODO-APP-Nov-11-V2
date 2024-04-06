```php
<?php

namespace Tests\Unit;

use App\Models\Task;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TaskTest extends TestCase
{
    use RefreshDatabase;

    public function testTaskCreation()
    {
        $user = User::factory()->create();

        $task = Task::factory()->make();

        $response = $this->actingAs($user)
                         ->post('/tasks', $task->toArray());

        $response->assertStatus(201);
        $this->assertDatabaseHas('tasks', ['title' => $task->title]);
    }

    public function testTaskUpdate()
    {
        $user = User::factory()->create();

        $task = Task::factory()->create(['user_id' => $user->id]);

        $updatedTask = ['title' => 'Updated Task Title'];

        $response = $this->actingAs($user)
                         ->put("/tasks/{$task->id}", $updatedTask);

        $response->assertStatus(200);
        $this->assertDatabaseHas('tasks', ['title' => 'Updated Task Title']);
    }

    public function testTaskDeletion()
    {
        $user = User::factory()->create();

        $task = Task::factory()->create(['user_id' => $user->id]);

        $response = $this->actingAs($user)
                         ->delete("/tasks/{$task->id}");

        $response->assertStatus(200);
        $this->assertDatabaseMissing('tasks', ['id' => $task->id]);
    }
}
```