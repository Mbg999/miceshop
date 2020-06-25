"use strict";
let esOptions = {
    sProcessing: "Procesando...",
    sLengthMenu: "Mostrar _MENU_ registros",
    sZeroRecords: "No se encontraron resultados",
    sEmptyTable: "Ningún dato disponible en esta tabla =(",
    sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
    sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
    sInfoPostFix: "",
    sSearch: "Buscar:",
    sUrl: "",
    sInfoThousands: ",",
    sLoadingRecords: "Cargando...",
    oPaginate: {
        sFirst: "Primero",
        sLast: "Último",
        sNext: "Siguiente",
        sPrevious: "Anterior"
    }
};

let esSorting = {
    sSortAscending: ": Activar para ordenar la columna de manera ascendente",
    sSortDescending: ": Activar para ordenar la columna de manera descendente"
};

let enOptions = {
    sEmptyTable: "No data available in table",
    sInfo: "Showing _START_ to _END_ of _TOTAL_ entries",
    sInfoEmpty: "Showing 0 to 0 of 0 entries",
    sInfoFiltered: "(filtered from _MAX_ total entries)",
    sInfoPostFix: "",
    sInfoThousands: ",",
    sLengthMenu: "Show _MENU_ entries",
    sLoadingRecords: "Loading...",
    sProcessing: "Processing...",
    sSearch: "Search:",
    sZeroRecords: "No matching records found",
    oPaginate: {
        sFirst: "First",
        sLast: "Last",
        sNext: "Next",
        sPrevious: "Previous"
    }
};

let enSorting = {
    sSortAscending: ": activate to sort column ascending",
    sSortDescending: ": activate to sort column descending"
};
$(() => {
    cargarDataTable();
    $("tbody").on("click", "tr", function () {
        window.location.href = ref + $(this).find("td:first").text();
    });
});

function isAdmin() {
    let c = document.cookie;
    if (!c) return "0";
    return c.substr(c.indexOf("client"), 8).split("=")[1];
}

function isEnglish() {
    let c = document.cookie;
    if (!c) return "0";
    return c.match("en=");
}

function cargarDataTable() {
    $("#table").DataTable({
        ajax: {
            url,
            headers: {
                'admin': isAdmin()
            },
            type: "get",
            dataSrc: function (d) {
                return d;
            },
            dataType: "json"
        },
        columns: (isEnglish()) ? en : es,
        bWidthAuto: true,
        sPaginationType: "full_numbers",
        language: (isEnglish()) ? enOptions : esOptions,
        oAria: (isEnglish()) ? enSorting : esSorting
    });
}
