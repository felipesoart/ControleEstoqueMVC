function set_dados_form(dados) {
    $('#id_cadastro').val(dados.Id);
    $('#txt_nome').val(dados.Nome);
    $('#txt_uf').val(dados.UF);
    $('#cbx_ativo').prop('checked', dados.Ativo);
    $('#ddl_pais').val(dados.IdPais);
}

function set_focus_form() {
    $('#txt_nome').focus();
}

//não é mais usado por conta do mustache ter centralizando o codigo em um so local (script index/pais) e (cadbase criar_linha_grid)
//function set_dados_grid(dados) {  //propriedade do grid
//    return '<td>' + dados.Nome + '</td>' +
//           '<td>' + dados.UF + '</td>' +
//           '<td>' + (dados.Ativo ? 'Sim' : 'Não') + '</td>';
//}

function get_dados_inclusao() { //incluir
    return {
        Id: 0,
        Nome: '',
        UF: '',
        Ativo: true,
        IdPais: 0
    };
}

function get_dados_form() { //alteração
    return {
        Id: $('#id_cadastro').val(),
        Nome: $('#txt_nome').val(),
        UF: $('#txt_uf').val(),
        Ativo: $('#cbx_ativo').prop('checked'),
        IdPais: $('#ddl_pais').val()
    };
}

function preencher_linha_grid(param, linha) { //atualiza grid apos o confirma
    linha
        .eq(0).html(param.Nome).end()
        .eq(1).html(param.UF).end()
        //.eq(2).html(param.Pais).end()
        .eq(2).html(param.Ativo ? 'SIM' : 'NÃO');
}

$(document).ready(function () {//carrega as linha do grid, por conta do mustache
    var grid = $('#grid_cadastro > tbody');
    for (var i = 0; i < linhas.length; i++) {
        grid.append(criar_linha_grid(linhas[i]));
    }
});


