import stm32f446

proc blinkUsingGpio
proc blinkUsingBitband
proc blinkVisibly
proc delay(ms: int)

proc main =
  # Must use fully-qualified ENABLE because of DCMI.CR.ENABLE
  RCC.AHB1ENR.GPIOAEN(RCC_AHB1ENR_GPIOAENVal.ENABLE).write()
  GPIOA.MODER.MODER5(OUTPUT).write()
  #blinkUsingGpio()
  #blinkUsingBitband()
  blinkVisibly()

proc blinkUsingGpio =
  while true:
    GPIOA.ODR.ODR5(0'u32).write()
    GPIOA.ODR.ODR5(1'u32).write()

proc blinkUsingBitband =
  const gpioA5set = 1'u32 shl 5
  const gpioA5reset = 1'u32 shl 21
  while true:
    GPIOA.BSRR = gpioA5set
    GPIOA.BSRR = gpioA5reset

proc blinkVisibly =
  const gpioA5set = 1'u32 shl 5
  const gpioA5reset = 1'u32 shl 21
  while true:
    GPIOA.BSRR = gpioA5set
    delay(1000)
    GPIOA.BSRR = gpioA5reset
    delay(1000)

proc delay(ms: int) =
  var m = ms
  while m > 0:
    dec m
    var x {.volatile.} = 500
    while x > 0:
      dec x

when isMainModule:
  main()
