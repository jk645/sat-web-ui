export default async function getAssets(): Promise<any> {
  const url = "http://localhost:9000/assets";
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Response status: ${response.status}`);
    }
    return response.json();
  } catch (error: any) {
    console.error(error.message);
    return null;
  }
}
