USE [MeuPet]
GO
/****** Object:  StoredProcedure [Administrativo].[spCriarUsuarios]    Script Date: 11/03/2023 18:51:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Administrativo].[spCriarUsuarios](
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



-- Processo para incluir as claims do usuário no ato que o mesmo é criado.
EXEC Administrativo.spCriarClaimsUsuario @AspNetUserId, 'UsuarioToken', NEWID, @Usuario
EXEC Administrativo.spCriarClaimsUsuario @AspNetUserId, 'FotoUsuario', '~/assets-admin/imagem/usuario/global/sem-foto.png', @Usuario
EXEC Administrativo.spCriarClaimsUsuario @AspNetUserId, 'EmpresaToken', @TokenEntidade, @Usuario
EXEC Administrativo.spCriarClaimsUsuario @AspNetUserId, 'UsuarioEmail', @EmailNovoUsuario, @Usuario

SET @NovoId = SCOPE_IDENTITY()

SELECT @NovoId as Id
END;
	





