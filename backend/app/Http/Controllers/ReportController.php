```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Report;
use App\Models\User;
use App\Models\Task;

class ReportController extends Controller
{
    /**
     * Generate a report for a specific user.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function generateUserReport($id)
    {
        $user = User::findOrFail($id);
        $tasks = Task::where('user_id', $id)->get();

        $report = new Report();
        $report->user_id = $user->id;
        $report->task_completion_rate = $this->calculateTaskCompletionRate($tasks);
        $report->productivity_score = $this->calculateProductivityScore($tasks);

        $report->save();

        return response()->json($report, 200);
    }

    /**
     * Calculate the task completion rate for a user.
     *
     * @param  \Illuminate\Database\Eloquent\Collection  $tasks
     * @return float
     */
    private function calculateTaskCompletionRate($tasks)
    {
        $completedTasks = $tasks->where('status', 'completed')->count();
        $totalTasks = $tasks->count();

        if ($totalTasks === 0) {
            return 0;
        }

        return ($completedTasks / $totalTasks) * 100;
    }

    /**
     * Calculate the productivity score for a user.
     *
     * @param  \Illuminate\Database\Eloquent\Collection  $tasks
     * @return float
     */
    private function calculateProductivityScore($tasks)
    {
        $totalTasks = $tasks->count();
        $highPriorityTasks = $tasks->where('priority', 'high')->count();

        if ($totalTasks === 0) {
            return 0;
        }

        return ($highPriorityTasks / $totalTasks) * 100;
    }
}
```