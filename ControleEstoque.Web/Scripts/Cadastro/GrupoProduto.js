function set_dados_form(dados) {
    $('#id_cadastro').val(dados.Id);
    $('#txt_nome').val(dados.Nome);
    $('#cbx_ativo').prop('checked', dados.Ativo);
}

function set_focus_form() {
    $('#txt_nome').focus();
}

//não é mais usado por conta do mustache ter centralizando o codigo em um so local (script index/pais) e (cadbase criar_linha_grid)
//function set_dados_grid(dados) {
//    return '<td>' + dados.Nome + '</td>' +
//           '<td>' + (dados.Ativo ? 'Sim' : 'Não') + '</td>';
//}

function get_dados_inclusao() {
    return {
        Id: 0,
        Nome: '',
        Ativo: true
    };
}

function get_dados_form() {
    return {
        Id: $('#id_cadastro').val(),
        Nome: $('#txt_nome').val(),
        Ativo: $('#cbx_ativo').prop('checked')
    };
}

function preencher_linha_grid(param, linha) {
    linha
        .eq(0).html(param.Nome).end()
        .eq(1).html(param.Ativo ? 'SIM' : 'NÃO');
}

$(document).ready(function () {//carrega as linha do grid, por conta do mustache
    var grid = $('#grid_cadastro > tbody');
    for (var i = 0; i < linhas.length; i++) {
        grid.append(criar_linha_grid(linhas[i]));
    }
});


//function marcar_ordenacao_campo(coluna) {
//    var ordem_crescente = true,
//        ordem = coluna.find('i');

//    if (ordem.length > 0) {
//        //ordem_crescente = ordem.hasClass('glyphicon-arrow-down');
//        ordem_crescente = ordem.hasClass('glyphicon-chevron-down');
//        if (ordem_crescente)
//        {
            
//            //ordem.removeClass('glyphicon-arrow-down');
//            //ordem.addClass('glyphicon glyphicon-arrow-up');
//            ordem.removeClass('glyphicon-chevron-down');
//            ordem.addClass('glyphicon glyphicon-chevron-up');
//        } else
//        {
//           // ordem.removeClass('glyphicon-arrow-up');
//           // ordem.addClass('glyphicon-arrow-down');
//            ordem.removeClass('glyphicon-chevron-up');
//            ordem.addClass('glyphicon-chevron-down');
//        }
//    }
//    else
//    {
//        $('.coluna-ordenacao i').remove();
//        coluna.append('&nbsp;<i class="glyphicon glyphicon-chevron-down" style="color: #000000"></i>');
//    }
//}


//function obter_ordem_grid() {
//    var colunas_grid = $('.coluna-ordenacao'),
//        ret = '';
//    colunas_grid.each(function (index, item) {
//        var coluna = $(item),
//            ordem = coluna.find('i');

//        if (ordem.length > 0) {
//            ordem_crescente = ordem.hasClass('glyphicon-chevron-down');
//            ret = coluna.attr('data-campo') + (ordem_crescente ? '' : ' desc');
//            return true;
//        }
//    });

//    return ret;
//}
