```php
<?php

namespace Tests\Unit;

use App\Models\Project;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProjectTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test project creation.
     *
     * @return void
     */
    public function testProjectCreation()
    {
        $project = Project::factory()->create();

        $this->assertDatabaseHas('projects', ['id' => $project->id]);
    }

    /**
     * Test project update.
     *
     * @return void
     */
    public function testProjectUpdate()
    {
        $project = Project::factory()->create();
        $project->update(['name' => 'Updated Project']);

        $this->assertDatabaseHas('projects', ['id' => $project->id, 'name' => 'Updated Project']);
    }

    /**
     * Test project deletion.
     *
     * @return void
     */
    public function testProjectDeletion()
    {
        $project = Project::factory()->create();
        $project->delete();

        $this->assertDatabaseMissing('projects', ['id' => $project->id]);
    }
}
```