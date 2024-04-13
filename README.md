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

* [PlatformIO](https://platformio.org/) - for the C compiler and platform libs.
* [nim-platformio](https://github.com/dwhall/nim-platformio/) - to compile Nim to C using PlatformIO build framework.
* [minisvd2nim](https://github.com/dwhall/minisvd2nim) - to convert the STM32 device SVD (XML) file to Nim source that enables register access by name.

The two constants in the source code define bit-set and bit-clear values
that are applied to the BSRR register of the GPIOA peripheral.
Thek bit-set then bit-clear loop is what makes the LED blink.
With the MCU running on the internal 12 MHz RC oscillator,
this code makes the LED blink at 3.3 MHz.  This blink frequency
is so fast you can't see it blink with your eyes; you just see an LED
that is dim because it is on less than 50% of the time.
