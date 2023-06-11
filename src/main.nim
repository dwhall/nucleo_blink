import stm32f446

proc main() =
  modifyIt(RCC.AHB1ENR): it.GPIOAEN= true
  modifyIt(GPIOA.MODER): it.MODER5= 1
  while true:
    GPIOA.BSRR.write((1 shl 5).GPIOA_BSRR_Fields)
    GPIOA.BSRR.write((1 shl 21).GPIOA_BSRR_Fields)

when isMainModule:
  main()
