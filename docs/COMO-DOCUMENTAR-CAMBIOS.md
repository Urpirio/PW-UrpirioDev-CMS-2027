# Cómo documentar un cambio

Este archivo define el formato y criterio para agregar entradas en los archivos `CHANGES.md` de cada módulo del CMS (Strapi).

---

## Cuándo agregar una entrada

Agrega una entrada cada vez que:

- Modificas el schema de un content-type (`schema.json`) — nuevos campos, relaciones, tipos
- Agregas, quitas o modificas lifecycle hooks (`content-types/*/lifecycles.ts`)
- Escribes o cambias controllers, services o routes personalizados (no generados por Strapi)
- Cambias permisos/roles de un content-type (público, autenticado, etc.)
- Agregas o eliminas endpoints custom en `routes/`
- Corriges un bug con impacto real en la API o en el comportamiento del admin panel
- Cambias configuración en `config/` que afecta comportamiento (plugins, middlewares, database, server)
- Migras o cambias la fuente de datos / integración externa de un módulo

**No** necesitas agregar entrada para:

- Cambios de labels o textos visibles solo en el admin panel sin impacto funcional
- Ajustes de estilos en componentes React del admin (`src/admin`, `src/components`)
- Reformateo automático del código (prettier, ESLint)
- Cambios en `types/generated/**` (se regeneran automáticamente)

---

## Dónde escribir

Abre `docs/api/[content-type]/CHANGES.md` (para módulos de `src/api/`) o `docs/admin/[componente]/CHANGES.md` / `docs/config/CHANGES.md` según corresponda, y agrega una nueva entrada al **inicio** del historial (más reciente primero).

Ejemplos de ubicación según el módulo tocado:

| Módulo tocado | Archivo de historial |
|---|---|
| `src/api/blog/**` | `docs/api/blog/CHANGES.md` |
| `src/api/proyecto/**` | `docs/api/proyecto/CHANGES.md` |
| `src/api/section-hero/**` | `docs/api/section-hero/CHANGES.md` |
| `src/admin/**` | `docs/admin/CHANGES.md` |
| `src/components/**` | `docs/components/CHANGES.md` |
| `config/**` | `docs/config/CHANGES.md` |

Después, actualiza la fila correspondiente en [CHANGELOG.md](CHANGELOG.md) con la fecha y descripción del cambio.

---

## Formato de una entrada

```markdown
## [YYYY-MM-DD] — Descripción corta del cambio

**Commit:** `abc1234`
**Tipo:** `feat` | `fix` | `refactor` | `chore`

### Qué cambió
- Punto concreto 1
- Punto concreto 2

### Por qué
Una o dos oraciones explicando la motivación o el problema que resolvió.

### Archivos tocados
- `src/api/[content-type]/content-types/[content-type]/schema.json`
- `src/api/[content-type]/controllers/[content-type].ts`
- `src/api/[content-type]/routes/[content-type].ts`

### Endpoints involucrados (opcional)
- `GET /api/[content-type]`
- `POST /api/[content-type]`
```

---

## Reglas de estilo

1. **Fecha del commit, no de hoy.** Busca la fecha con `git log --oneline --date=short -- [archivo]`.
2. **Commit hash:** los primeros 7 caracteres son suficientes (`git log --oneline`).
3. **"Qué cambió" en bullets concretos.** Evita "se mejoró la API" — di qué campo, endpoint o hook específico cambió.
4. **"Por qué" en prosa.** Si el contexto es un cambio de permisos, una integración externa o una decisión técnica, menciónalo.
5. **Archivos tocados:** solo los archivos relevantes al cambio descrito, no todos los del commit.
6. **Las más recientes van arriba** en el archivo.
7. **Si el cambio tocó varios `CHANGES.md`:** documenta en cada módulo afectado, incluso si el commit es el mismo.

---

## Ejemplo completo

Este repositorio todavía no tiene historial de commits ni módulos documentados. En cuanto exista el primer cambio documentado, referencia aquí su `CHANGES.md` como ejemplo (p. ej. `docs/api/blog/CHANGES.md`).
