<?php

use App\CouponCode;
use Illuminate\Database\Seeder;

class CouponCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(CouponCode::class, 10)->create();
    }
}
