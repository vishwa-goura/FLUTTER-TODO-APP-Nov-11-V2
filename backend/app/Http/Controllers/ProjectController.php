```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Project;

class ProjectController extends Controller
{
    public function createProject(Request $request)
    {
        $project = new Project;
        $project->name = $request->name;
        $project->description = $request->description;
        $project->user_id = $request->user_id;
        $project->save();

        return response()->json([
            'status' => 'success',
            'message' => 'Project created successfully',
            'data' => $project
        ]);
    }

    public function updateProject(Request $request, $id)
    {
        $project = Project::find($id);
        $project->name = $request->name;
        $project->description = $request->description;
        $project->save();

        return response()->json([
            'status' => 'success',
            'message' => 'Project updated successfully',
            'data' => $project
        ]);
    }

    public function deleteProject($id)
    {
        $project = Project::find($id);
        $project->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Project deleted successfully'
        ]);
    }

    public function getProject($id)
    {
        $project = Project::find($id);

        return response()->json([
            'status' => 'success',
            'data' => $project
        ]);
    }

    public function getAllProjects()
    {
        $projects = Project::all();

        return response()->json([
            'status' => 'success',
            'data' => $projects
        ]);
    }
}
```