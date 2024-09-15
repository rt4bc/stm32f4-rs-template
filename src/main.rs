#![no_std]
#![no_main]
use cortex_m_rt::entry;
use panic_halt as _;

use stm32f4xx_hal::{pac, prelude::*};

use rtt_target::{rprintln, rtt_init_print};

#[entry]
fn main() -> ! {
    rtt_init_print!();

    let dp = pac::Peripherals::take().unwrap();
    let gpioa = dp.GPIOA.split();
    let mut led = gpioa.pa5.into_push_pull_output().erase();
    let mut counter = 0_u8;

    loop {
        rprintln!("Loop counter: {}", counter);
        counter = counter.wrapping_add(1);

        // your code goes here
        for _ in 0..10_000 {
            led.set_high();
        }
        for _ in 0..10_000 {
            led.set_low();
        }
    }
}
