```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\User;
use App\Models\Project;

class ProjectTest extends TestCase
{
    use RefreshDatabase;

    public function testCreateProject()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $projectData = [
            'name' => 'Test Project',
            'description' => 'This is a test project',
        ];

        $response = $this->post('/api/projects', $projectData);

        $response->assertStatus(201);
        $this->assertDatabaseHas('projects', $projectData);
    }

    public function testUpdateProject()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $project = Project::factory()->create(['user_id' => $user->id]);

        $updatedProjectData = [
            'name' => 'Updated Test Project',
            'description' => 'This is an updated test project',
        ];

        $response = $this->put("/api/projects/{$project->id}", $updatedProjectData);

        $response->assertStatus(200);
        $this->assertDatabaseHas('projects', $updatedProjectData);
    }

    public function testDeleteProject()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $project = Project::factory()->create(['user_id' => $user->id]);

        $response = $this->delete("/api/projects/{$project->id}");

        $response->assertStatus(204);
        $this->assertDatabaseMissing('projects', ['id' => $project->id]);
    }
}
```