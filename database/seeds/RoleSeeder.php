<?php

use App\Role;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Role::create([
            'name' => 'Author',
            'description' => 'An authour can submit papers'
        ]);
        Role::create([
            'name' => 'Reviewer',
            'description' => 'A Reviewer can review submissions'
        ]);
        Role::create([
            'name' => 'Admin',
            'description' => 'An Admin'
        ]);
        Role::create([
            'name' => 'SuperAdmin',
            'description' => 'A Super Admin'
        ]);
    }
}
