```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\User;
use App\Models\Task;

class TaskTest extends TestCase
{
    use RefreshDatabase;

    public function testTaskCreation()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $taskData = [
            'title' => 'Test Task',
            'description' => 'This is a test task',
            'priority' => 'High',
            'deadline' => '2022-12-31'
        ];

        $response = $this->post('/task', $taskData);

        $response->assertStatus(201);
        $this->assertDatabaseHas('tasks', $taskData);
    }

    public function testTaskUpdate()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $task = Task::factory()->create(['user_id' => $user->id]);

        $updatedTaskData = [
            'title' => 'Updated Test Task',
            'description' => 'This is an updated test task',
            'priority' => 'Medium',
            'deadline' => '2022-12-31'
        ];

        $response = $this->put('/task/'.$task->id, $updatedTaskData);

        $response->assertStatus(200);
        $this->assertDatabaseHas('tasks', $updatedTaskData);
    }

    public function testTaskDeletion()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $task = Task::factory()->create(['user_id' => $user->id]);

        $response = $this->delete('/task/'.$task->id);

        $response->assertStatus(200);
        $this->assertDeleted($task);
    }
}
```