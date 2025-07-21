<template>
    <div class="q-pa-md">
        <q-table
            flat
            :rows="allPDVs"
            :columns="columns"
            class="my-sticky-column-table"

        >
            <template v-slot:no-data>
                <div class="flex justify-center w-full">
                    Sem dados no momento ...
                </div>
            </template>

            <template v-slot:body-cell-actions="props">
                <q-td :props="props" class="q-gutter-sm shadow-lg sticky w-full top-0 z-10 bg-white">
                    <q-btn dense flat icon="more_vert">
                        <q-menu>
                            <q-list style="min-width: 120px">
                            <q-item clickable v-close-popup>
                                <q-item-section>Editar</q-item-section>
                            </q-item>
                            <q-item clickable v-close-popup>
                                <q-item-section>Excluir</q-item-section>
                            </q-item>
                            </q-list>
                        </q-menu>
                    </q-btn>
                </q-td>
            </template>
        </q-table>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage, QTableColumn } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';    

    const columns: QTableColumn[] = [
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center'
        },
        
        {name: 'pdv_code', label: 'Cód', field: 'pdv_code', align: 'center' },
        {name: 'description', label: 'Descrição', field: 'description', align: 'center' },
        {name: 'pdv_code', label: 'Nota N°', field: 'pdv_code', align: 'center' },
        {name: 'customer_id', label: 'Cód cliente', field: 'customer_id', align: 'center' },
        {name: 'customer', label: 'Cliente', field: 'customer', align: 'center' },
        {name: 'pdv_code', label: 'Documento', field: 'pdv_code', align: 'center' },
        {
            name: 'gross_value', 
            label: 'Total bruto', 
            field: 'gross_value', 
            align: 'center', 
            format(val) {
                return val.replace('.', ',')
            },  },
        {
            name: 'net_value', 
            label: 'Tota líquido', 
            field: 'net_value', 
            align: 'center', 
            format(val) {
                return val.replace('.', ',')
            }, 
        },
        {
            name: 'addition', 
            label: 'Acréscimo', 
            field: 'addition', 
            align: 'center', 
            format(val) {
                return val.replace('.', ',')
            },  },
        {
            name: 'discount', 
            label: 'Desconto', 
            field: 'discount', 
            align: 'center', 
            format(val) {
                return val.replace('.', ',')
            },  
        },
        {name: 'user_id', label: 'Cód vendedor', field: 'user_id', align: 'center' },
        {name: 'user', label: 'Vendedor', field: 'user', align: 'center' },
        {
            name: 'is_nfce_nm', 
            label: 'Tipo venda', 
            field: 'is_nfce_nm', 
            align: 'center',
            format(val: string){
                return val.toUpperCase();
            },
            
        },
        {name: 'status', label: 'Status da venda', field: 'status', align: 'center' },
        {
            name: 'canceled', 
            label: 'Cancelada', 
            field: 'canceled', 
            align: 'center',
            format(val){
                return val === 1 ? 'Sim' : 'Não'
            }
        },
        {
            name: 'finished', 
            label: 'Finalizada', 
            field: 'finished', 
            align: 'center',
            format(val){
                return val === 1 ? 'Sim' : 'Não'
            }

        }
    ];

    let allPDVs = ref([]);

    const getAllPDVs = async () => {
        const res = await api.get(`/ecommerce/pdv/all/${LocalStorage.getItem("issuer_id")}`);
        console.log(res.data)
        allPDVs.value = res.data;
    };

    onMounted(() => {
        getAllPDVs();

    });
</script>

<style lang="sass">
.my-sticky-column-table
  /* specifying max-width so the example can
    highlight the sticky column on any browser window */
  max-width: 160vh

  thead tr:first-child th:first-child
    /* bg color is important for th; just specify one */
    background-color: #fff

 

  th:first-child,
  td:first-child
    position: sticky
    left: 0
    z-index: 1
</style>