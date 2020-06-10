<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Submission;
use Faker\Generator as Faker;

$factory->define(Submission::class, function (Faker $faker) {
    return [
        'subject_id' => $faker->numberBetween($min = 1, $max = 20),
        'title' => $faker->sentence,
        'status' => $faker->randomElement(['pending', 'approved', 'rejected']),
        'file' => '/submissions/' . $faker->randomNumber() . '.pdf'
    ];
});
