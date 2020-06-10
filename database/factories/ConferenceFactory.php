<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Conference;
use Faker\Generator as Faker;

$factory->define(Conference::class, function (Faker $faker) {
    return [
        'title' => $faker->sentence,
        'description' => $faker->sentence,
        'date' => $faker->date,
        'venue' => $faker->city,
        'total_seats' => $faker->numberBetween(1000, 2000),
        'available_seats' => $faker->numberBetween(100, 200)
    ];
});
