```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Task;

class TaskController extends Controller
{
    public function createTask(Request $request)
    {
        $task = new Task;
        $task->title = $request->title;
        $task->description = $request->description;
        $task->priority = $request->priority;
        $task->deadline = $request->deadline;
        $task->user_id = $request->user()->id;
        $task->save();

        return response()->json(['task' => $task], 201);
    }

    public function updateTask(Request $request, $id)
    {
        $task = Task::findOrFail($id);
        $task->title = $request->title;
        $task->description = $request->description;
        $task->priority = $request->priority;
        $task->deadline = $request->deadline;
        $task->save();

        return response()->json(['task' => $task], 200);
    }

    public function deleteTask($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();

        return response()->json(null, 204);
    }

    public function getTask($id)
    {
        $task = Task::findOrFail($id);

        return response()->json(['task' => $task], 200);
    }

    public function getAllTasks(Request $request)
    {
        $tasks = Task::where('user_id', $request->user()->id)->get();

        return response()->json(['tasks' => $tasks], 200);
    }
}
```