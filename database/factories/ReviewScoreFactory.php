<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\ReviewScore;
use Faker\Generator as Faker;

$factory->define(ReviewScore::class, function (Faker $faker) {
    return [
        'submission_id' => $faker->numberBetween($min = 1, $max = 50),
        'completeness' => $faker->randomElement([5.1, 2.3, 2.2, 5.1]),
        'subject_knowledge' => $faker->randomElement([5.1, 2.3, 2.2, 5.1]),
        'comments' => $faker->sentence,
    ];
});
