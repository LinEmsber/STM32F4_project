#target remote :3333
target remote :4242
load
b *_exit
c
quit
