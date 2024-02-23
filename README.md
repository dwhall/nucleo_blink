# nucleo_blink

Blinks the LED of an
[ST Nucleo F446RE board](https://www.st.com/en/evaluation-tools/nucleo-f446re.html)
featuring the [STM32F446RE](https://www.st.com/en/microcontrollers-microprocessors/stm32f446.html)
microcontroller using software written in the
[Nim programming language](https://nim-lang.org/):

```nim
import stm32f446

proc main =
  RCC.AHB1ENR.GPIOAEN(1).write()
  GPIOA.MODER.MODER5(1).write()

  # Use bit-banding to blink GPIO A5 very quickly (dims an LED)
  const gpioA5set = 1'u32 shl 5
  const gpioA5reset = 1'u32 shl 21
  while true:
    GPIOA.BSRR = gpioA5set
    GPIOA.BSRR = gpioA5reset

when isMainModule:
  main()
```

This project makes use of these tools:

* [PlatformIO](https://platformio.org/)
* [nim-platformio](https://github.com/dwhall/nim-platformio/)
* minisvd2nim - coming soon

I am currently working in forks of the latter two tools, but I
will get them unified if the original authors so choose.

The use of `shl` above is a temporary wart that I am working on;
bits 5 and 21 activate the bit-set and bit-clear functions in the
BSRR register of the GPIOA peripheral.  That's what makes it blink.
With the MCU running on the internal 12 MHz RC oscillator,
this code makes the LED blink at 3.3 MHz.  This fast blink frequency
means you can't see the LED blink with your eyes, you just see an LED
that is dim because it is on less than 50% of the time.
