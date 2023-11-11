```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\Report;
use App\Models\User;

class ReportTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test report generation.
     *
     * @return void
     */
    public function testReportGeneration()
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)
                         ->post('/report/generate', [
                             'user_id' => $user->id,
                             'start_date' => '2021-01-01',
                             'end_date' => '2021-12-31'
                         ]);

        $response->assertStatus(200);
    }

    /**
     * Test report retrieval.
     *
     * @return void
     */
    public function testReportRetrieval()
    {
        $user = User::factory()->create();
        $report = Report::factory()->create(['user_id' => $user->id]);

        $response = $this->actingAs($user)
                         ->get('/report/'.$report->id);

        $response->assertStatus(200)
                 ->assertJson([
                     'id' => $report->id,
                     'user_id' => $user->id
                 ]);
    }
}
```