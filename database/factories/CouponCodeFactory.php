<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\CouponCode;
use Illuminate\Support\Str;
use Faker\Generator as Faker;

$factory->define(CouponCode::class, function (Faker $faker) {
    return [
        'conference_id' => $faker->numberBetween(1, 10),
        'vendor' => $faker->company,
        'coupon_code' => strtoupper(Str::random(5)),
        'discount' => $faker->randomElement([2.5, 10, 15])
    ];
});
