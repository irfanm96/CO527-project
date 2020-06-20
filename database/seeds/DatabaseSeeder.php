<?php

use App\Submission;
use App\SupportTicket;
use App\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        DB::unprepared(file_get_contents('files/cms.sql'));
        $this->call(CountriesTableSeeder::class);
        $this->call(SubjectsTableSeeder::class);
        $this->call(RoleSeeder::class);
        $this->call(ConferenceSeeder::class);

        $roles = [1, 2, 3, 4];
        factory(User::class, 1000)->create()->each(function ($user) use ($roles) {
            $user->roles()->attach($roles[array_rand($roles)]);
            $user->submissions()->saveMany(factory(Submission::class, rand(1, 10))->make());
            $user->supportTickets()->saveMany(factory(SupportTicket::class, rand(1, 3))->make());
        });
        $this->call(ReviewScoreTableSeeder::class);
        $this->call(TicketSeeder::class);
        $this->call(CouponCodeSeeder::class);
    }
}
