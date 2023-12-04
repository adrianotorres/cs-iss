export async function fetchData(url: string, method = "GET", data = {}) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]') as HTMLMetaElement
  const response = await fetch(url, {
    method: method,
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken ? csrfToken.content : '',
    },
    body: method === "GET" ? undefined : JSON.stringify(data),
  });

  if (response.ok) {
    return await response.json();
  } else {
    console.error(`Erro na requisição ${method} para ${url}`);
    return null;
  }
}
