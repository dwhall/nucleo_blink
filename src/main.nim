import stm32f446

proc main =
  RCC.AHB1ENR.GPIOAEN(1).write()
  GPIOA.MODER.MODER5(1).write()

  const gpioA5set = 1'u32 shl 5
  const gpioA5reset = 1'u32 shl 21
  while true:
    GPIOA.BSRR = gpioA5set
    GPIOA.BSRR = gpioA5reset

when isMainModule:
  main()
