ALTER PROCEDURE Administrativo.spCriarUsuarios(
	@EmpresaToken VARCHAR(36),
	@AspNetUserId VARCHAR(256),
	@Nome VARCHAR(100),
	@Sobrenome VARCHAR(100),
	@Usuario VARCHAR(256)
)

AS BEGIN

DECLARE @ValidarUsuarioExistente INT;
DECLARE @RetornarUsuarioId INT;
DECLARE @TokenEntidade INT;
DECLARE @RetornarEmpresaId INT;
DECLARE @NovoId INT;

SET @ValidarUsuarioExistente = Administrativo.fnVerificarUsuarioExistente(@Usuario);
	IF(@ValidarUsuarioExistente = 0)
		THROW 51000, 'Usuário inválido, tente novamente por favor!', 1;

SET @RetornarUsuarioId = Administrativo.fnRetornarUsuarioId(@Usuario);
	IF(@RetornarUsuarioId = 0)
		THROW 51000, 'Não foi possível encontrar o usuário, tente novamente por favor!', 1;

SET @TokenEntidade = ISNULL((SELECT 1 FROM Administrativo.Empresas empresas WHERE empresas.Token = @EmpresaToken), 0)
	IF(@TokenEntidade = 0)
		THROW 51000, 'Não foi possível validar o token da empresa, tente novamente por favor!', 1;

SET @RetornarEmpresaId = Administrativo.fnRetornarEmpresaId(@Usuario);
	IF(@RetornarEmpresaId = 0)
		THROW 51000, 'Não é possível continuar sem empresa, tente novamente por favor!', 1;


INSERT Administrativo.Usuarios(
	EmpresaId,
	AspNetUserId,
	Token,
	Nome,
	Sobrenome,
	CriadoPor,
	EditadoPor,
	CriadoEm,
	EditadoEm,
	Ativo
)VALUES(

	@RetornarEmpresaId,
	@AspNetUserId,
	NEWID(),
	@Nome,
	@Sobrenome,
	@RetornarUsuarioId,
	@RetornarUsuarioId,
	GETDATE(),
	GETDATE(),
	1

)

SET @NovoId = SCOPE_IDENTITY()

SELECT @NovoId as Id

END;
	





