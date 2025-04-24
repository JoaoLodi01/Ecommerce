<template>
    <div class="p-3 text-white">
        <h3 class="ml-4">Filtros</h3>
        <div>
            <q-input 
                v-model="start" 
                type="date"
                label="De" 
                filled            
                label-color="black"
                text-color="black"
                bg-color="white"
                class="m-3"
            />

            <q-input 
                v-model="end" 
                type="date"
                label="Até" 
                filled            
                label-color="black"
                text-color="black"
                bg-color="white"
                class="m-3"

            />

            <q-select 
                v-model="seller.oneSeller" 
                :options="options" 
                option-label="name"
                option-value="id"
                label="Vendedor"
                filled            
                label-color="black"
                text-color="black"
                bg-color="white"
                class="m-3"

            />

            <q-checkbox 
                left-label 
                v-model="seller.allSellers" 
                label="Todos os vendedors" 
                class="m-3"
                color="grey"
            />
            
            <q-checkbox 
                left-label 
                v-model="sales.nm" 
                label="Nota Manual" 
                class="m-3"
                color="grey"
            />

            <q-checkbox 
                left-label 
                v-model="sales.nfce" 
                label="NFC-e" 
                class="m-3"
                color="grey"
            />

            <div class="ml-4">
                <q-btn 
                    color="grey"
                    label="Imprimir" 
                    @click="submitReport()" 
                />
                
                <q-btn 
                    class="ml-10"
                    color="grey"
                    label="Cancelar" 
                />
                
            </div>
        </div>

    </div>
</template>

<script>
import { LocalStorage } from 'quasar';
import { api } from 'src/boot/axios';

    export default {
        data()
        {
            return {
                start: null,
                end: null,
                options: [],
                sales: {
                    nfce: false,
                    nm: false

                },

                seller: {
                    oneSeller: '',
                    oneSellerID: 0,
                    allSellers: false,

                }
                
            }
        },

        methods: {
            async submitReport()
            {
                console.log(this.seller)
                const response = await api.post('report/pdv/closing-period', {
                    start: this.start,
                    end: this.end,
                    nfce: this.sales.nfce ? 'nfce' : null,
                    nm: this.sales.nm ? 'nm' : null,
                    seller: this.seller
                });
            
            }
        },

        mounted()
        {
            const getAllSellers = async () => {
                const response = await api.get('/users/all') 
                this.options = response.data
                
                
            }
            getAllSellers()

            const getUser = async () => { 
                const response = await api.get('/auth/me', {
                    headers: {
                        'Authorization': `Bearer ${LocalStorage.getItem("auth_token")}`
                    }
                })
                const details = response.data   

                this.seller = {
                    allSellers: false,
                    oneSeller: details.user.name,
                    oneSellerID: details.user.id,
                }

            }
            getUser()
        }
    }
</script>