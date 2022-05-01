function set_dados_form(dados) {

    $('#id_cadastro').val(dados.Id);
    $('#txt_nome').val(dados.Nome);
   
    $('#txt_num_documento').val(dados.NumDocumento);
    $('#txt_razao_social').val(dados.RazaoSocial);
    $('#txt_telefone').val(dados.Telefone);
    $('#txt_contato').val(dados.Contato);
    $('#txt_logradouro').val(dados.Logradouro);
    $('#txt_numero').val(dados.Numero);
    $('#txt_complemento').val(dados.Complemento);
    $('#txt_cep').val(dados.Cep);

    $('#cbx_pessoa_juridica').prop('checked', false);
    $('#cbx_pessoa_fisica').prop('checked', false);

    if (dados.Tipo == 2) {
        $('#cbx_pessoa_juridica').prop('checked', true).trigger('click');
    }
    else {
        $('#cbx_pessoa_fisica').prop('checked', true).trigger('click');
    }

    $('#ddl_pais').val(dados.IdPais);
    

    preencher_ddl_Estado(dados.IdEstado);
    $('#ddl_estado').val(dados.IdEstado);
    $('#ddl_estado').prop('disabled', dados.IdEstado <= 0 || dados.IdEstado == undefined);

    preencher_ddl_Cidade(dados.IdCidade);
    $('#ddl_cidade').val(dados.IdCidade);
    $('#ddl_cidade').prop('disabled', dados.IdCidade <= 0 || dados.IdCidade == undefined);

    $('#cbx_ativo').prop('checked', dados.Ativo);
}

function set_focus_form() {
    $('#txt_nome').focus();
}

//não é mais usado por conta do mustache ter centralizando o codigo em um so local(script index / pais) e(cadbase criar_linha_grid)
//function set_dados_grid(dados) {  //propriedade do grid
//    return '<td>' + dados.Nome + '</td>' +
//           '<td>' + dados.Telefone + '</td>' +
//           '<td>' + dados.Contato + '</td>' +
//           '<td>' + (dados.Ativo ? 'Sim' : 'Não') + '</td>';
//}

function get_dados_inclusao() { //incluir

    return {

        Id: 0,
        Nome: '',
        RazaoSocial: '',
        NumDocumento: '',
        Tipo: 2,
        Telefone: '',
        Contato: '',
        Logradouro: '',
        Numero: '',
        Complemento: '',
        Cep: '',
        IdPais: 0,
        IdEstado: 0,
        IdCidade: 0,
        Ativo: true,

    };
}

function get_dados_form() { //alteração

    return {
        Id: $('#id_cadastro').val(),
        Nome: $('#txt_nome').val(),

        RazaoSocial: $('#txt_razao_social').val(),
        NumDocumento: $('#txt_num_documento').val(),
        Tipo: $('#cbx_pessoa_juridica').is(':checked') ? 2 : 1,
        Telefone: $('#txt_telefone').val(),
        Contato: $('#txt_contato').val(),
        Logradouro: $('#txt_logradouro').val(),
        Numero: $('#txt_numero').val(),
        Complemento: $('#txt_complemento').val(),
        Cep: $('#txt_cep').val(),

        IdPais: $('#ddl_pais').val(),
        IdEstado: $('#ddl_estado').val(),
        IdCidade: $('#ddl_cidade').val(),
        Ativo: $('#cbx_ativo').prop('checked'),
    };

}

function preencher_linha_grid(param, linha) { //atualiza grid apos o confirma
    linha
        .eq(0).html(param.Nome).end()
        .eq(1).html(param.Telefone).end()
        .eq(2).html(param.Contato).end()
        .eq(3).html(param.Ativo ? 'SIM' : 'NÃO');
}

$(document).ready(function () {
    var grid = $('#grid_cadastro > tbody');
    for (var i = 0; i < linhas.length; i++) {
        grid.append(criar_linha_grid(linhas[i]));
    }
});

$(document).on('change', '#ddl_pais', function estado() {//função para o preenchimento do dropdrawlist do estado
    preencher_ddl_Estado(IdEstado = 0);
});

$(document).on('change', '#ddl_estado', function cidade() {//função para o preenchimento do dropdrawlist do estado    
    preencher_ddl_Cidade(IdCidade = 0);
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
    }
    else {
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

function preencher_ddl_Cidade(IdCidade) {

    if (IdCidade == 0) {
        var ddl_estado = $('#ddl_estado'),
            id_estado = parseInt(ddl_estado.val()),
            ddl_cidade = $('#ddl_cidade');

        if (id_estado > 0) {
            var url = url_listar_cidades,
                param = { idEstado: id_estado };



            ddl_cidade.empty(); //limpa a variavel
            $('#ddl_cidade').prop('disabled', true);

            $.post(url, add_anti_forgery_token(param), function (response) {
                if (response && response.length > 0) {
                    for (var i = 0; i < response.length; i++) {
                        ddl_cidade.append('<option value=' + response[i].Id + '>' + response[i].Nome + '</option>');
                    }
                    $('#ddl_cidade').prop('disabled', false);
                }
            });
        }
    }
    else {
        var ddl_cidade = $('#ddl_cidade'),

            url = url_cidades,
            param = { idCidade: IdCidade };

        ddl_cidade.empty(); //limpa a variavel
        $('#ddl_cidade').prop('disabled', true);

        $.post(url, add_anti_forgery_token(param), function (response) {
            if (response && response.length > 0) {

                ddl_cidade.append('<option value=' + response[0].Id + '>' + response[0].Nome + '</option>');

                $('#ddl_cidade').prop('disabled', false);
            }
        });
    }
}


$(document)
    .ready(function () {//<<<assim que carrega a pagina execulta isso
                     

        $('#txt_telefone').mask('(00) 00000-0000', { placeholder: "(00) 00000-0000" });
        $('#txt_contato').mask('(00) 00000-0000', { placeholder: "(00) 00000-0000" });
        $('#txt_cep').mask('00000-000', { placeholder: "00000-000" });
     //   $('#container_razao_social').addClass('invisible')
      //  $('#txt_num_documento').addClass('invisible')
      //  $('label[for="txt_num_documento"]').addClass('invisible')
    })

    .on('click', '#cbx_pessoa_juridica', function () {
        $('#txt_num_documento').mask('00.000.000/0000-00', { placeholder: "00.000.000/0000-00" });
        //obter o valor no console
        //jj = parseInt($('#cbx_pessoa').val()),
        //    console.log(jj);

        $('label[for="txt_num_documento"]').text('CNPJ');
        $('#txt_num_documento').mask('00.000.000/0000-00', { reverse: true });
        $('#container_razao_social').removeClass('invisible')
       
    })

    .on('click', '#cbx_pessoa_fisica', function () {
        $('#txt_num_documento').mask('000.000.000-00', { placeholder: "000.000.000-00" });
        //obter o valor no console
        //jj = parseInt($('#cbx_pessoa').val()),
        //   console.log(jj);


        $('label[for="txt_num_documento"]').text('CPF');
        $('#txt_num_documento').mask('000.000.000-00', { reverse: true });
        $('#container_razao_social').addClass('invisible')
        
      //  $('#txt_num_documento').removeClass('invisible')
      //  $('label[for="txt_num_documento"]').removeClass('invisible')
    });