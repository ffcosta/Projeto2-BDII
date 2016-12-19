<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%-- 1.0.0 --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%!String val(javax.servlet.http.HttpServletRequest request, String param) {
		return val(request, param, "");
	}%>
<%!String val(javax.servlet.http.HttpServletRequest request, String param, String defaultValue) {
		String value = request.getParameter(param);
		return value == null || value.trim().equals("") ? defaultValue : value;
	}%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Conexao BD</title>
<link rel="shortcut icon"
	href="https://raw.githubusercontent.com/websys-co/jsp-db-client/master/src/main/webapp/favicon.ico">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<style>
body {
	padding-top: 15px;
}
</style>
<!--[if lt IE 9]>
  <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<form name="frm" method="post" accept-charset="utf-8">
				<input type="hidden" name="op" value="run">
				<div class="col-sm-12">
					<div class="panel panel-info">
						<div class="panel-heading col-sm-12">Opções da aplicação disponíveis para interação com o Banco de Dados Oracle 11g Enterprise</div>
						<div class="panel-body">
							<div class="row">

								<div class="col-sm-2">
									<div class="form-group">
										<%
											String selectListar = val(request, "selectListar");
										%>
										<legend>Selecionar Tabelas</legend>
										<select id="selectbasic" name="selectListar"
											class="form-control">
											
											<option value="Endereco">Endereço</option>
											<option value="Pessoa">Pessoa</option>
											<option value="Instituto">Instituto</option>
											<option value="Coordenador">Coordenador</option>
											<option value="Tecnico_adm">Técnico Adm</option>
											<option value="Professor">Professor</option>
											<option value="Curso">Curso</option>
											<option value="Aluno">Aluno</option>
											<option value="Disciplina">Disciplina</option>
											<option value="Turma">Turma</option>
											<option value="Graduacao">Graduação</option>
											<option value="Grade_curricular">Grade Curricular</option>
											<option value="telefone_pessoa">Telefone pessoa</option>
											<option value="horario_turma">Horario turma</option>
											<option value="sala_turma">Sala turma</option>
											<option value="turmas_semestre">Turmas semestre</option>
											<option value="notas_turmas">Notas turmas</option>


										</select>
									</div>
									<div class="col-sm-2">
								
									<div class="form-group">
										<button type="submit" name="executar" value="1"
											class="btn btn-primary pull-left">Listar</button>
									</div>
								</div>
								</div>
								
								<div class="col-sm-2">
									<div class="form-group">
										<%
											String selectConsultar = val(request, "selectConsultar");
										%>
										<legend>Executar Consultas</legend>
										<select id="selectbasic" name="selectConsultar"
											class="form-control">
											<%
											String c1 = "SELECT Matricula, NomeComp, NomeDisc, Nota FROM PESSOA NATURAL JOIN NOTAS_TURMAS NATURAL JOIN DISCIPLINA WHERE NOTA >= 6 AND SEMESTRE = 1 AND ANO = 2015";
											String c2 = "SELECT NomeComp, NomeDisc, HorasFaltas FROM PESSOA NATURAL JOIN TURMAS_SEMESTRE NATURAL JOIN DISCIPLINA WHERE Matricula = 2013083322 AND SEMESTRE = 1 AND ANO = 2014 And CodDisc = 110";
											String c3 = "SELECT DISTINCT Matricula, NomeComp, atendesp FROM ALUNO NATURAL JOIN PESSOA NATURAL JOIN GRADUACAO WHERE atendesp = 'Sim' AND SituacaoGrad = 'Ingresso' AND DtMudancaSit BETWEEN '01-01-2009' AND '12-12-2010'";
											String c4 = "SELECT NomeInst, AVG(Salario) AS MediaSalario FROM PROFESSOR NATURAL JOIN INSTITUTO GROUP BY NomeInst";
											String c5 = "SELECT  DISTINCT Cpf, NomeComp, NomeCurso FROM PESSOA NATURAL JOIN ALUNO NATURAL JOIN CURSO Where CODC = 055 and sexo = 'F'";
											String c6 = "SELECT NomeCurso, Count(Cpf) as QtdeTotal FROM PESSOA NATURAL JOIN ALUNO NATURAL JOIN CURSO GROUP BY NomeCurso";
											String c7 = "SELECT NomeComp, NomeCurso, Dt_Nasc FROM PESSOA NATURAL JOIN ALUNO NATURAL JOIN CURSO WHERE NomeCurso = 'MEDICINA'";
											String c8 = "SELECT NomeComp, Cpf, NomeCurso FROM PESSOA NATURAL JOIN ALUNO NATURAL JOIN CURSO WHERE NomeCurso = 'SISTEMAS DE INFORMACAO' AND DtMat > '31-12-2013'";
											String c9 = "SELECT DISTINCT NomeComp, NomeDisc, Semestre, Ano, Nota, StatusAluno FROM NOTAS_TURMAS NATURAL JOIN PESSOA NATURAL JOIN TURMAS_SEMESTRE NATURAL JOIN DISCIPLINA NATURAL JOIN CURSO WHERE CURSO.MATCOOR = '1999103687' AND SEMESTRE = '2' AND ANO = 2005 AND NomeDisc = 'Arquitetura de Computadores'";
											String c10 = "SELECT NomeComp, NomeCurso, SituacaoGrad, DtMudancaSit FROM GRADUACAO NATURAL JOIN PESSOA NATURAL JOIN CURSO WHERE MATCOOR = '1999103687' AND SituacaoGrad = 'Trancada'";
											String c11 = "SELECT NomeDisc, Semestre, Ano FROM TURMAS_SEMESTRE NATURAL JOIN DISCIPLINA NATURAL JOIN GRADE_CURRICULAR NATURAL JOIN CURSO WHERE MATCOOR = '2005017689' AND SEMESTRE = '1' AND ANO = 2012";
											String c12 = "SELECT NomeComp, NomeDisc, Semestre, Ano, StatusAluno FROM PESSOA NATURAL JOIN ALUNO NATURAL JOIN TURMAS_SEMESTRE NATURAL JOIN DISCIPLINA NATURAL JOIN GRADE_CURRICULAR NATURAL JOIN CURSO WHERE MATCOOR = '2005017689' AND SEMESTRE = '2' AND ANO = 2014 AND StatusAluno = 'Reprovado'";
											String c13 = "select Matricula, NomeComp, telefone from TELEFONE_PESSOA NATURAL JOIN PESSOA WHERE MATRICULA = '2015086743'";
											String c14= "SELECT Matricula, nomecomp, nota, statusaluno from TURMAS_SEMESTRE NATURAL JOIN NOTAS_TURMAS NATURAL JOIN PESSOA WHERE CODDISC = 13 AND SEMESTRE = '1' AND ANO = '2016' AND MATRICULA = '2015086743'";
											String c15 = "select Matricula, NomeComp, horasfaltas, statusaluno from turmas_semestre NATURAL JOIN PESSOA WHERE CODDISC = 141 AND SEMESTRE = '1' AND ANO = '2016' AND MATRICULA = '2014080453'";
											%>
											<option	value="<%=c1%>">C1</option>
											<option value="<%=c2%>">C2</option>
											<option value="<%=c3%>">C3</option>
											<option value="<%=c4%>">C4</option>
											<option value="<%=c5%>">C5</option>
											<option value="<%=c6%>">C6</option>
											<option value="<%=c7%>">C7</option>
											<option value="<%=c8%>">C8</option>
											<option value="<%=c9%>">C9</option>
											<option value="<%=c10%>">C10</option>
											<option value="<%=c11%>">C11</option>
											<option value="<%=c12%>">C12</option>
											<option value="<%=c13%>">C13-A1</option>
											<option value="<%=c14%>">C14-A2</option>
											<option value="<%=c15%>">C15-A3</option>
										</select>
									</div>
									<div class="col-sm-2">
									<div class="form-group">
										<button type="submit" name="executar" value="2"	class="btn btn-primary pull-left">Executar</button>
									</div>
								</div>
								</div>
								
								<div class="col-sm-2">
									<div class="form-group">
										<%
											String selectAtualizar = val(request, "selectAtualizar");
										%>
										<legend>Realizar Atualizações</legend>
										<select id="selectbasic" name="selectAtualizar"
											class="form-control">
											<%
											String a1 = "UPDATE TELEFONE_PESSOA SET TELEFONE = '62988891166' WHERE MATRICULA = '2015086743' AND TELEFONE = '6288891166'";
											String a2 = "UPDATE NOTAS_TURMAS SET NOTA = 8 WHERE CODDISC = 13 AND SEMESTRE = '1' AND ANO = '2016' AND MATRICULA = '2015086743'";
											String a3 = "UPDATE TURMAS_SEMESTRE SET HORASFALTAS = 0 WHERE CODDISC = 141 AND SEMESTRE = '1' AND ANO = '2016' AND MATRICULA = '2014080453'";
											%>
											<option	value="<%=a1%>">A1</option>
											<option value="<%=a2%>">A2</option>
											<option value="<%=a3%>">A3</option>
										</select>
									</div>
									<div class=" row col-sm-4">
									<div class="form-group">
									<div class=" row col-sm-3" ><button type="submit" name="executar" value="3"	class="btn btn-primary pull-left">Atualizar</button></div>		
									</div>
								</div>
								</div>
								

							</div>

						</div>

					</div>
					<%
						String url = "jdbc:oracle:thin:@localhost:1521:orcl";
						String user = "user_univers";
						String password = "123456";
						String max = "100";
						String sql;
						String botao =  val(request, "executar");
						if (botao.equals("1")) {
							sql = "select * from " + val(request, "selectListar");
						} else if (botao.equals("2")){
							sql = val(request, "selectConsultar");
						} else if (botao.equals("3")){
							sql = val(request, "selectAtualizar");
						}
						
						else
							sql = "select * from aluno";

						String op = val(request, "op");
						if (op.equals("run")) {
							Connection conn = null;
							try {
								conn = DriverManager.getConnection(url, user, password);
								Statement stmt = conn.createStatement();
								boolean isResultSet = stmt.execute(sql);
								if (isResultSet) {
									ResultSet rs = stmt.getResultSet();
									if (rs.next()) {
					%>
					<div class="panel panel-success" id="resultPanel">
					<% String textoResult;
					   String consulta = val(request, "selectConsultar");
					if(botao.equals("1"))
						textoResult = "Conteudo da tabela " + val(request, "selectListar");
					else{
						if(consulta.equals(c1))
							textoResult = "Consula 1 (C1) - Selecionar nome e nota dos alunos que que foram aprovados no X semestre ano Y (Aprovação Nota  >= 6.0). Exemplo: 1º semestre de 2015";
						else if(consulta.equals(c2))
							textoResult = "Consula 2 (C2) - Selecionar nome, disciplina e quantidade de horas de falta o aluno de matricula X teve no Y semestre de ano Z na disciplina D. Exemplo: 1º semestre 2014, disciplina Arquitetura de Computadores";
						else if(consulta.equals(c3))
							textoResult = "Consula 3 (C3) - Selecionar matricula nome dos alunos que necessitam de atendimento especial que ingressaram entre os anos de X e Y. Exemplo: nos anos de 2009 e 2010";
						else if(consulta.equals(c4))
							textoResult = "Consula 4 (C4) - Selecionar a média salarial dos professores agrupados por instituto.";
						else if(consulta.equals(c5))
							textoResult = "Consula 5 (C5) - Selecionar Cpf, Nome de todas as alunas que cursaram ou cursam o curso X. Exemplo: Curso Sistemas de Informação Codigo 55";
						else if(consulta.equals(c6))
							textoResult = "Consula 6 (C6) - Selecionar a quantidade de todos os alunos que ingressaram universidade agrupado por curso.";
						else if(consulta.equals(c7))
							textoResult = "Consula 7 (C7) - Selecionar o nome e data de nascimento dos alunos do curso X. Exemplo: Curso de Medicina";
						else if(consulta.equals(c8))
							textoResult = "Consula 8 (C8) - Selecionar nome, cpf dos alunos matriculados no curso X, do ano Y até o ano atual. Exemplo: Curso SISTEMAS DE INFORMACAO e data de matricula > 31-12-2013";
					    else if(consulta.equals(c9))
							textoResult = "Consula 9 (C9) - Em quais disciplinas os alunos, sob coordenadoria de X foram aprovados  no ano Y, Z semestre na disciplina D? Exemplo: Coordenador ROBERTO TELLES ANTUNES NETO Matricula: 1999103687";
					    else if(consulta.equals(c10))
							textoResult = "Consula 10 (C10) - quais alunos, sob coordenadoria de X, tiveram as matrículas trancadas, inclusive a data do trancamento? Exemplo: Coordenador ROBERTO TELLES ANTUNES NETO Matricula: 1999103687";
						else if(consulta.equals(c11))
							textoResult = "Consula 11 (C11) - quais turmas, sob coordenadoria de X, cadastradas no ano X e semestre Y? Exemplo: Coordenadora ANA RITA DE CASSIA Matricula:  2005017689";
						else if(consulta.equals(c12))
							textoResult = "Consula 12 (C12) - quais alunos, sob coordenadoria de X, foram reprovados no ano X e semestre Y? Exemplo: Coordenadora ANA RITA DE CASSIA Matricula:  2005017689";
						else if(consulta.equals(c13))
							textoResult = "Consula 13 (C13-A1) - Dados que serão modificados na atualização 1. Nesta caso será o telefone";
						else if(consulta.equals(c14))
							textoResult = "Consula 14 (C14-A2) - Dados que serão modificados na atualização 2. Nesta caso será a nota do aluno de matrícula 2015086743";
						else if(consulta.equals(c15))
							textoResult = "Consula 15 (C15-A3) - Dados que serão modificados na atualização 3. Nesta caso será a quantidade de faltas";
						else textoResult = "algo deu errado";
					}
					
						%>
						<div class="panel-heading"><%=textoResult%></div>
						<table border="1" class="table table-condensed">
							<thead>
								<tr>
									<%
										ResultSetMetaData rsmd = rs.getMetaData();
														int columnCount = rsmd.getColumnCount();
														for (int i = 1; i <= columnCount; i++) {
															String columnName = rsmd.getColumnName(i);
									%>
									<th><%=columnName%></th>
									<%
										}
									%>
								</tr>
							</thead>
							<tbody>
								<%
									int maxRegs = Integer.parseInt(max);
													int numRegs = 1;
													do {
								%>
								<tr>
									<%
										for (int i = 1; i <= columnCount; i++) {
																String value = rs.getString(i);
									%>
									<td><%=value%></td>
									<%
										}
									%>
								</tr>
								<%
									} while (++numRegs <= maxRegs && rs.next());
								%>
							</tbody>
						</table>
					</div>
					<%
						} else {
					%>
					<div class="panel panel-success" id="resultPanel">
						<div class="panel-heading">Sucesso</div>
						<div class="panel-body">
							<p>Nenhum registro foi encontrado.</p>
						</div>
					</div>
					<%
						}
								} else {
									int updateCount = stmt.getUpdateCount();
					%>
					<div class="panel panel-success" id="resultPanel">
						<div class="panel-heading">Sucesso</div>
						<div class="panel-body">
							<p>
								O SQL foi executado com sucesso:
								<mark><%=updateCount%>
									registro(s) alterado(s).
								</mark>
							</p>
						</div>
					</div>
					<%
						}
							} catch (Throwable e) {
					%>
					<div class="panel panel-danger" id="resultPanel">
						<div class="panel-heading">Erro</div>
						<div class="panel-body">
							<p>
								A execução do SQL falhou:
								<mark><%=e.getClass().getName() + " - " + e.getMessage()%></mark>
							</p>
						</div>
					</div>
					<%
						} finally {
								if (conn != null) {
									try {
										conn.close();
									} catch (Throwable e) {
										//Não há o que fazer.        
									}
								}
							}
					%>
					<script>
						function scroll() {
							var resultPanel = $("#resultPanel");
							if (resultPanel.length) {
								$("html, body").animate({
									scrollTop : resultPanel.offset().top
								}, 600);
							}
						}
					</script>
					<%
						} else {
					%>
					<script>
						function scroll() {
						}
					</script>
					<%
						}
					%>
				</div>
			</form>
		</div>
	</div>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script>
		$(document).ready(function() {
			setTimeout(scroll, 300);
		});
	</script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script>
		/*!
		 * IE10 viewport hack for Surface/desktop Windows 8 bug
		 * Copyright 2014 Twitter, Inc.
		 * Licensed under the Creative Commons Attribution 3.0 Unported License. For
		 * details, see http://creativecommons.org/licenses/by/3.0/.
		 */

		// See the Getting Started docs for more information:
		// http://getbootstrap.com/getting-started/#support-ie10-width
		(function() {
			'use strict';
			if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
				var msViewportStyle = document.createElement('style')
				msViewportStyle.appendChild(document
						.createTextNode('@-ms-viewport{width:auto!important}'))
				document.querySelector('head').appendChild(msViewportStyle)
			}
		})();
	</script>
</body>
</html>