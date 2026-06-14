const request = require("supertest");
const app = require("../src/app");

describe("API REST - Pruebas básicas", () => {
  test("GET / debe responder Backend funcionando", async () => {
    const response = await request(app).get("/");

    expect(response.statusCode).toBe(200);
    expect(response.text).toBe("Backend funcionando");
  });

  test("POST /api/auth/login debe validar correo y password obligatorios", async () => {
    const response = await request(app)
      .post("/api/auth/login")
      .send({ correo: "admin@test.com" });

    expect(response.statusCode).toBe(400);
    expect(response.body.mensaje).toBe("Correo y password son obligatorios");
  });

  test("POST /api/auth/forgot-password debe generar token", async () => {
    const response = await request(app)
      .post("/api/auth/forgot-password")
      .send({ correo: "admin@test.com" });

    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty("tokenSimulado");
  });

  test("POST /api/logs debe registrar un log", async () => {
    const response = await request(app)
      .post("/api/logs")
      .send({
        usuario: "Juan Perez",
        ip: "127.0.0.1",
        accion: "login"
      });

    expect(response.statusCode).toBe(201);
    expect(response.body.data.usuario).toBe("Juan Perez");
    expect(response.body.data.accion).toBe("login");
  });

  test("GET /api/logs debe obtener logs", async () => {
    const response = await request(app).get("/api/logs");

    expect(response.statusCode).toBe(200);
    expect(response.body.ok).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });
});
