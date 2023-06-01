import stm32f446

proc main() =
  modifyIt(RCC.AHB1ENR): it.GPIOAEN= true
  modifyIt(GPIOA.MODER): it.MODER5= 1
  while true:
    GPIOA.BSRR.write(BS5=true)
    GPIOA.BSRR.write(BR5=true)

when isMainModule:
  main()
