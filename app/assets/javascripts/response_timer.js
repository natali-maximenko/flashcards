function timer_tick(sec) {
  $('#response_time').val(sec);
}

setTimeout(timer_tick, 10000, 10);
setTimeout(timer_tick, 30000, 30);
setTimeout(timer_tick, 60000, 60);
