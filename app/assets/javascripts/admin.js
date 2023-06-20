$(document).ready(() => {
  $('.disabled').on('click', (e) => {
    e.preventDefault();
    $('.flashes').html('<div class="flash flash_error">La tarea está bloqueada por su dependencia con otra tarea. Finalice la tarea de la cual depende para poder agregar nuevas respuestas.</div>');
    return false;
  });
});
