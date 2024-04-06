```php
<?php

namespace Tests\Unit;

use App\Models\Report;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ReportTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test report creation.
     *
     * @return void
     */
    public function testReportCreation()
    {
        $report = Report::factory()->create();

        $this->assertDatabaseHas('reports', ['id' => $report->id]);
    }

    /**
     * Test report update.
     *
     * @return void
     */
    public function testReportUpdate()
    {
        $report = Report::factory()->create();
        $report->update(['title' => 'Updated Report']);

        $this->assertDatabaseHas('reports', ['id' => $report->id, 'title' => 'Updated Report']);
    }

    /**
     * Test report deletion.
     *
     * @return void
     */
    public function testReportDeletion()
    {
        $report = Report::factory()->create();
        $report->delete();

        $this->assertDatabaseMissing('reports', ['id' => $report->id]);
    }
}
```