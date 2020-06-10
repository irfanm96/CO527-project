<?php

use App\ReviewScore;
use Illuminate\Database\Seeder;

class ReviewScoreTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(ReviewScore::class, 100)->create();
    }
}
