function set_dados_form(dados) {
    $('#id_cadastro').val(dados.Id);
    $('#txt_nome').val(dados.Nome);
    $('#ddl_pais').val(dados.IdPais);   
    $('#cbx_ativo').prop('checked', dados.Ativo);
  
    preencher_ddl_Estado(dados.IdEstado);

    $('#ddl_estado').val(dados.IdEstado);
    $('#ddl_estado').prop('disabled', dados.IdEstado <= 0 || dados.IdEstado == undefined);
    
}

function set_focus_form() {
    $('#txt_nome').focus();
}

//não é mais usado por conta do mustache ter centralizando o codigo em um so local (script index/pais) e (cadbase criar_linha_grid)
//function set_dados_grid(dados) {  //propriedade do grid 
//    return '<td>' + dados.Nome + '</td>' +
//           '<td>' + (dados.Ativo ? 'Sim' : 'Não') + '</td>';
//}

function get_dados_inclusao() { //incluir
    return {
        Id: 0,
        Nome: '',
        IdPais: 0,
        IdEstado: 0,
        Ativo: true,       
    };
}

function get_dados_form() { //alteração
    
    return {        
        Id: $('#id_cadastro').val(),
        Nome: $('#txt_nome').val(),
        IdPais: $('#ddl_pais').val(),        
        Ativo: $('#cbx_ativo').prop('checked'),
        IdEstado: $('#ddl_estado').val(),
       
    };
    
}

function preencher_linha_grid(param, linha) { //atualiza grid apos o confirma
    linha
        .eq(0).html(param.Nome).end()        
        .eq(1).html(param.Ativo ? 'SIM' : 'NÃO');
}

$(document).on('change', '#ddl_pais', function () {//função para o preenchimento do dropdrawlist do estado
    preencher_ddl_Estado(IdEstado = 0);

});

function preencher_ddl_Estado(IdEstado) {
    
    if (IdEstado == 0) {
        var ddl_pais = $('#ddl_pais'),
            id_pais = parseInt(ddl_pais.val()),
            ddl_estado = $('#ddl_estado');

        if (id_pais > 0) {
            var url = url_listar_estados,
                param = { idPais: id_pais };



            ddl_estado.empty(); //limpa a variavel
            $('#ddl_estado').prop('disabled', true);

            $.post(url, add_anti_forgery_token(param), function (response) {
                if (response && response.length > 0) {
                    for (var i = 0; i < response.length; i++) {
                        ddl_estado.append('<option value=' + response[i].Id + '>' + response[i].Nome + '</option>');
                    }
                    $('#ddl_estado').prop('disabled', false);
                }
            });
        }
    } else {
        var ddl_estado = $('#ddl_estado'),
          
                url = url_estados,
                param = { idEstado: IdEstado };

        ddl_estado.empty(); //limpa a variavel
        $('#ddl_estado').prop('disabled', true);

            $.post(url, add_anti_forgery_token(param), function (response) {
                if (response && response.length > 0) {
                    
                    ddl_estado.append('<option value=' + response[0].Id + '>' + response[0].Nome + '</option>');
                   
                    $('#ddl_estado').prop('disabled', false);
                }
            });
       
    }
}

$(document).ready(function () { //carrega as linha do grid, por conta do mustache
    var grid = $('#grid_cadastro > tbody');
    for (var i = 0; i < linhas.length; i++) {
        grid.append(criar_linha_grid(linhas[i]));
    }
});


