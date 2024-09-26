# `Hackathon` | PosTech 5SOAT • Grupo 25

![infra](https://img.shields.io/badge/infra-blue?color=%23d63865) ![python](https://img.shields.io/badge/Python-505050?logo=python&logoColor=FFFFFF&labelColor=3776AB) ![terraform](https://img.shields.io/badge/Terraform-505050?logo=terraform&logoColor=FFFFFF&labelColor=844FBA) ![aws](https://img.shields.io/badge/Amazon%20Web%20Services-505050?logo=amazonwebservices&logoColor=FFFFFF&labelColor=FF9900) [![sonarcloud](https://sonarcloud.io/api/project_badges/measure?project=postech-5soat-grupo-25_hackathon-infra&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=postech-5soat-grupo-25_hackathon-infra)

## Sobre o Projeto

Este projeto é desenvolvido como parte do Hackathon, um requisito para a conclusão do curso de Pós-Graduação em Software Architecture da FIAP. O desafio proposto visa solucionar problemas reais enfrentados pela Health&Med, uma operadora de saúde em expansão, por meio do desenvolvimento de um sistema digital de agendamento de consultas médicas. Atualmente, o agendamento é realizado por telefone, o que gera lentidão no processo. Nosso sistema busca digitalizar o agendamento, cadastro e gerenciamento de horários de médicos, proporcionando uma experiência mais ágil para pacientes e melhorando a eficiência operacional da empresa.

---

### Equipe

| Membro                                                                        | RM       |
|-------------------------------------------------------------------------------|----------|
| [Alan Marques Molina](https://www.linkedin.com/in/alanmmolina/)               | `353062` |
| [Albert Dias Moreira](https://www.linkedin.com/in/albert-moreira-62b9272b/)   | `352569` |
| [Bruno Mafra Pelence](https://www.linkedin.com/in/bruno-mafra-pelence/)       | `352939` |
| [Lucas Felipe Rebello](https://www.linkedin.com/in/lucas-rebello-b01849112/)  | `352982` |
| [Matheus Bachiste Lopes](https://www.linkedin.com/in/matheus-bachiste-lopes/) | `352783` |

---

### Documentação

Acesse nossa **documentação completa** em:

[postech-5soat-grupo-25.github.io](https://postech-5soat-grupo-25.github.io/)

## Como Executar

### Configuração dos Secrets

Certifique-se de ter os seguintes secrets configurados a nível de organização:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### Deploy/Destroy via GitHub Actions

- Para **criar** a infraestrutura, utilize o workflow `Hackathon Infra Deploy`. 
- Para **destruir** a infraestrutura, utilize o workflow `Hackathon Infra Destroy`. 

### Deploy/Destroy em Ambiente Local

Este repositório também inclui um `Makefile` para simplificar o processo de criação e destruição da infraestrutura.

Para criar, execute o seguinte comando:

```bash
make deploy
```

Para destruir, utilize o comando:

```bash
make destroy
```
