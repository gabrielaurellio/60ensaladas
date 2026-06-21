#!/bin/bash
TOKEN="SEU_TOKEN_AQUI"  # não commitar o token real aqui
REPO="60ensaladas"
USER="gabrielaurellio"

echo "==> Criando repositório no GitHub..."
curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO\",\"private\":false,\"auto_init\":false}" | grep -o '"full_name":"[^"]*"'

echo ""
echo "==> Configurando remote e fazendo push..."
git remote add origin https://$USER:$TOKEN@github.com/$USER/$REPO.git
git push -u origin main

echo ""
echo "==> Ativando GitHub Pages..."
curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$USER/$REPO/pages \
  -d '{"source":{"branch":"main","path":"/"}}' | grep -o '"url":"[^"]*"'

echo ""
echo "==> Pronto! Aguarde 2-5 minutos e acesse: https://60ensaladas.labuenavida.online/"
echo ""
echo "==> Ainda precisa configurar o DNS do domínio:"
echo "    Tipo: CNAME"
echo "    Nome: 60ensaladas"
echo "    Valor: gabrielaurellio.github.io"
