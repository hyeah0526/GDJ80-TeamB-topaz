$(document).ready(function() {
     $('#checkInBtn').on('click', function() {
         $(this).addClass('active').prop('disabled', true);
         $('#checkOutBtn').prop('disabled', false);
     });

     $('#checkOutBtn').on('click', function() {
         $(this).addClass('active').prop('disabled', true);
     });
 });