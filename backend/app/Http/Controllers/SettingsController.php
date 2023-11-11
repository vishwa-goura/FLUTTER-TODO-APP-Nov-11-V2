```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SystemSetting;

class SettingsController extends Controller
{
    /**
     * Display a listing of the system settings.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $settings = SystemSetting::all();
        return response()->json($settings);
    }

    /**
     * Update the specified system setting in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $setting = SystemSetting::findOrFail($id);
        $setting->update($request->all());

        return response()->json($setting, 200);
    }
}
```