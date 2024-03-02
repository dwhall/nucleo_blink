import stm32f446

proc ms_delay(ms: int) =
  var m = ms
  while m > 0:
    dec m
    var x {.volatile.} = 500
    while x > 0:
      dec x

proc main =
  RCC.AHB1ENR.GPIOAEN(1).write()
  GPIOA.MODER.MODER5(1).write()

  const gpioA5set = 1'u32 shl 5
  const gpioA5reset = 1'u32 shl 21
  while true:
    GPIOA.BSRR = gpioA5set
    ms_delay(250)
    GPIOA.BSRR = gpioA5reset
    ms_delay(250)

when isMainModule:
  main()
