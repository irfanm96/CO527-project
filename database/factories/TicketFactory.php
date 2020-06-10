<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Ticket;
use Faker\Generator as Faker;

$factory->define(Ticket::class, function (Faker $faker) {
    return [
        'user_id' => $faker->randomElement([1, 2, 3, 4, 5, 6]),
        'conference_id' => $faker->randomElement([1, 2, 3, 4, 5, 6]),
        'type' => $faker->randomElement(['General-admission', 'VIP', 'Reserved-Seating', 'Early-bird-discount', 'Coded-discount']),
        'price' => $faker->numberBetween(1000, 2000),
    ];
});
