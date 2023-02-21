CREATE PROCEDURE [Administrativo].[spEditarEmpresa](
	@Token VARCHAR(36),
	@Nome VARCHAR(100),
	@CNPJ VARCHAR(18),
	@DataAbertura DATETIME2,
	@Email VARCHAR(256),
	@CEP VARCHAR(9),
	@Endereco VARCHAR(100),
	@Numero VARCHAR(5),
	@Complemento VARCHAR(50),
	@Bairro VARCHAR(100),
	@Cidade VARCHAR(100),
	@Estado VARCHAR(100),
	@Whatsapp VARCHAR(16),
	@Logo VARCHAR(256),
	@Usuario VARCHAR(256)
)

AS BEGIN

DECLARE @ValidarUsuarioExistente INT;
DECLARE @RetornarUsuarioId INT;
DECLARE @RetornarEmpresaId INT;
DECLARE @TokenEntidade INT;

IF(@Usuario IS NULL)
	THROW 51000, 'Por favor informar o usuário.', 1;

SET @TokenEntidade = ISNULL((SELECT 1 FROM Administrativo.Empresas empresas WHERE empresas.Token = @Token), 0)
	IF(@TokenEntidade = 0)
		THROW 51000, 'Não foi possível validar o token da empresa, tente novamente por favor!', 1;

SET @ValidarUsuarioExistente = Administrativo.fnVerificarUsuarioExistente(@Usuario);
	IF(@ValidarUsuarioExistente = 0)
		THROW 51000, 'Usuário inválido, tente novamente por favor!', 1;

SET @RetornarUsuarioId = Administrativo.fnRetornarUsuarioId(@Usuario);
	IF(@RetornarUsuarioId = 0)
		THROW 51000, 'Não foi possível encontrar o usuário, tente novamente por favor!', 1;

SET @RetornarEmpresaId = Administrativo.fnRetornarEmpresaId(@Usuario);
	IF(@RetornarEmpresaId = 0)
		THROW 51000, 'Não é possível continuar sem empresa, tente novamente por favor!', 1;

UPDATE Administrativo.Empresas
	SET
		Nome = @Nome,
		CNPJ = @CNPJ,
		DataAbertura = @DataAbertura,
		Email = @Email,
		CEP = @CEP,
		Endereco = @Endereco,
		Numero = @Numero,
		Complemento = @Complemento,
		Bairro = @Bairro,
		Cidade = @Cidade,
		Estado = @Estado,
		Whatsapp = @Whatsapp,
		Logo = @Logo
	WHERE Token = @Token
	AND EmpresaId = @RetornarEmpresaId
END;