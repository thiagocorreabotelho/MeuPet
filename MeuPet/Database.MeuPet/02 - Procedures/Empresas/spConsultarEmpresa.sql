CREATE PROCEDURE [Administrativo].[spConsultarEmpresa](@Token VARCHAR(36), @Usuario VARCHAR(256))

AS BEGIN

SET NOCOUNT ON;

DECLARE @ValidarUsuarioExistente INT;
DECLARE @RetornarUsuarioId INT;
DECLARE @RetornarEmpresaId INT;
DECLARE @TokenEntidade INT;

SET @TokenEntidade = ISNULL((SELECT 1 FROM Administrativo.Empresas empresas WHERE empresas.Token = @Token), 0)
	IF(@TokenEntidade = 0)
		THROW 51000, 'Não foi possível validar o token da empresa, tente novamente por favor!', 1;

IF(@Usuario IS NULL)
	THROW 5100, 'Por favor informar o usuário.', 1;

SET @ValidarUsuarioExistente = Administrativo.fnVerificarUsuarioExistente(@Usuario);
	IF(@ValidarUsuarioExistente = 0)
		THROW 51000, 'Usuário inválido, tente novamente por favor!', 1;

SET @RetornarUsuarioId = Administrativo.fnRetornarUsuarioId(@Usuario);
	IF(@RetornarUsuarioId = 0)
		THROW 51000, 'Não foi possível encontrar o usuário, tente novamente por favor!', 1;

SET @RetornarEmpresaId = Administrativo.fnRetornarEmpresaId(@Usuario);
	IF(@RetornarEmpresaId = 0)
		THROW 51000, 'Não é possível continuar sem empresa, tente novamente por favor!', 1;

SELECT
	empresas.EmpresaId,
	empresas.Token, 
	empresas.Nome,
	empresas.CNPJ,
	empresas.DataAbertura,
	empresas.Email,
	empresas.CEP,
	empresas.Endereco,
	empresas.Numero,
	empresas.Complemento,
	empresas.Bairro,
	empresas.Cidade,
	empresas.Estado,
	empresas.Whatsapp,
	empresas.Logo
FROM Administrativo.Empresas empresas
WHERE empresas.EmpresaId = @RetornarEmpresaId
END;