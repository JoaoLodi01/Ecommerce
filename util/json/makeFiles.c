#include <stdio.h>

int main()
{
    FILE *file = fopen("data.json", "w");
    if(file == NULL)
    {
        perror("Erro ao abrir o arquivo");
        return 1;

    }

    const char *json_data = "{\n"
                            "   \"product\": \"Teste\", \n"
                            "   \"barcode\": \"1111111111\", \n"
                            "   \"barcode_internal\": \"1111111111\", \n"
                            "   \"group_id\": \"\", \n"
                            "   \"amount\": \"11111\", \n"
                            "   \"cost_price\": \"10\", \n"
                            "   \"sale_price\": \"100\", \n"
                            "   \"profit_percentage\": \"100\", \n"
                            "   \"cfop\": \"5102\", \n"
                            "   \"csosncst\": \"102\", \n"
                            "   \"ncm\": \"1111111111\", \n"
                            "   \"cest\": \"111111\", \n"
                            "   \"unit\": \"111\", \n"
                            "   \"origem_icms\": \"11111\", \n"
                            "   \"icms_ecf\": \"11111\", \n"
                            "   \"taxable_amount\": \"11111\", \n"
                            "   \"taxable_unit\": \"11111\", \n"
                            "   \"tax_benefit\": \"11111\", \n"
                            "   \"cod_ipi\": \"11111\", \n"
                            "   \"aliquot_ipi\": \"11111\", \n"
                            "   \"cod_pis\": \"11111\", \n"
                            "   \"aliquot_pis\": \"11111\", \n"
                            "   \"cod_cofins\": \"11111\", \n"
                            "   \"aliquot_cofins\": \"11111\" \n"

                            "}";

    fprintf(file, "%s", json_data);

    fclose(file);
    return 0;
}