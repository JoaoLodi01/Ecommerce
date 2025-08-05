<template>
	<div v-if="!showPage">
		<LoandingPage
			@show-page="showPage = $event"
			text="Carregando registros do pagar ..."
		/>
	</div>

	<div v-if="showPage" class="mt-10 mb-5 p-6 bg-white rounded-lg shadow-lg mx-auto w-[90%] max-w-[1400px]">
		<div class="flex justify-between items-center mb-6">
			<h1 class="text-2xl font-semibold">Pagar</h1>
            <div class="flex space-x-4">
				<q-btn
					class="p-2 rounded-lg"
					:style="`background-color: ${buttonColor}; color: ${textColor}`"
				>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 16 16"
						fill="currentColor"
						class="w-6 h-6"
					>
						<path
							fill-rule="evenodd"
							d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z"
							clip-rule="evenodd"
						/>
					</svg>
				</q-btn>

				<q-btn
					class="p-2 rounded-lg"
					:style="`background-color: ${buttonColor}; color: ${textColor}`"
					label="Relatórios"
				/>

				<q-btn
					class="p-2 rounded-lg"
					:style="`background-color: ${buttonColor}; color: ${textColor}`"
					@click="manageClick(0, 'register', false)"
					label="Cadastrar"
				/>
			</div>
        </div>

        <div class="filterDate flex  gap-4 items-end mb-6 p-3 border border-gray-300 rounded-lg w-full ">
			<div class="flex gap-2">
				<q-input
					class="cursor-text"
					type="date"
					v-model="startDate"
					label="Data Inicial"
				/>

				<q-input
					class="cursor-text"
					type="date"
					v-model="endDate"
					label="Data Final"
				/>
			</div>

			<q-btn-dropdown
				class="h-10"
				:style="`background-color: ${buttonColor}; color: ${textColor}`"
				flat
				dropdown-icon="arrow_drop_down">

				<q-list dense>
					
				</q-list>
			</q-btn-dropdown>

			<q-btn-dropdown
				class="h-10"
				:style="`background-color: ${buttonColor}; color: ${textColor}`"
				flat
				dropdown-icon="arrow_drop_down">

				<q-list dense>
					
				</q-list>
			</q-btn-dropdown>

			<q-btn
				class="transition text-white h-10"
				:style="`background-color: ${buttonColor}; color: ${textColor}`"
				label="Filtrar"
			/>
		</div>

        <div class="flex flex-col md:flex-row md:justify-between gap-4 items-center border p-3 rounded-lg mb-4 mx-auto w-full">
			<!-- Legenda  -->
			<div class="flex gap-4">
				<div class="flex items-center gap-2 text-xs">
					<div class="bg-black h-3 w-3 rounded-full"></div>
					<span>Em Aberto</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-green-500 h-3 w-3 rounded-full"></div>
					<span>Quitadas</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-blue-500 h-3 w-3 rounded-full"></div>
					<span>Quitada com atraso</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-orange-500 h-3 w-3 rounded-full"></div>
					<span>Canceladas</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-red-500 h-3 w-3 rounded-full"></div>
					<span>Atrasadas</span>
				</div>
			</div>

			<!-- Totalizadores -->
			<div class="flex gap-4">
				<span class="border rounded px-3 py-1 bg-green-200 text-green-900">
					<q-icon name="check_circle" color="green-700" class="mr-2 mb-1" />
					Recebidas: R$ {{ totalQuitadas }}
				</span>

				<span class="border rounded px-3 py-1 bg-yellow-200 text-yellow-900">
					<q-icon name="hourglass_empty" color="orange" class="mr-2 mb-1" />
					Pendentes: R$ {{ totalEmAberto }}
				</span>

				<span class="border rounded px-3 py-1 bg-red-300 text-red-900">
					<q-icon name="warning" color="red" class="mr-2 mb-1" />
					Atrasadas ( + juros ): R$ {{ totalVencidas }}
				</span>
			</div>
		</div>

        <q-table
            :rows="cashs"
            :columns="columns"
            row-key="name"
            flat
            bordered
            class="q-mt-md shadow-lg rounded-lg"
        >
            <template v-slot:header="props">
                <q-tr :props="props" :style="`background-color: ${painelColor}; color: ${textColor};`">
                    <q-th v-for="col in props.cols" :key="col.name" :props="props" :class="`text-${col.align}`">
                        {{ col.label }}
                    </q-th>
                </q-tr>
            </template>

            <template v-slot:body="props">
				<q-tr :props="props" :class="getColorToPay(props.row)">
					<q-td key="document" :props="props" class="text-left">
						{{ props.row.document }}
					</q-td>

					<q-td key="description" :props="props" class="text-left">
						{{ props.row.description }}
					</q-td>

					<q-td key="installmentAmount" :props="props" class="text-center">
						{{ props.row.installmentAmount }}
					</q-td>

					<q-td key="installmentNumber" :props="props" class="text-center">
						{{ props.row.installmentNumber }}
					</q-td>

					<q-td key="installmentValue" :props="props" class="text-right">
						R$ {{ Number(props.row.installmentValue).toFixed(2) }}
					</q-td>

					<q-td key="installmentPaid" :props="props" class="text-right">
						R$ {{ Number(props.row.installmentPaid).toFixed(2) }}
					</q-td>

					<q-td key="name" :props="props" class="text-left">
						{{ props.row.name }}
					</q-td>

					<q-td key="dueDate" :props="props" class="text-center">
						{{ props.row.dueDate }}
					</q-td>

					<q-td key="especie" :props="props" class="text-center">
						{{ props.row.especie.toUpperCase() }}
					</q-td>

					<q-td key="status" :props="props" class="text-center">
						<q-badge
							:color="getStatusBadge(props.row).color"
							class="text-xs"
							outline
							:label="getStatusBadge(props.row).label"
							:icon="getStatusBadge(props.row).icon"
						/>
					</q-td>

					<q-td key="actions" :props="props" class="text-center">
						<q-btn
							@click="manageClick(props.row.receiveDocument, 'update', false)"
							icon="edit"
							color="green"
							size="sm"
							class="q-mr-xs"
						/>
						<q-btn
							@click="manageClick(props.row.document, 'view', true)"
							icon="visibility"
							color="blue"
							size="sm"
							class="q-mr-xs"
						/>

						<q-btn-dropdown
							size="sm"
							:style="`background-color: ${buttonColor}; color: ${textColor}`"
							flat
							dropdown-icon="arrow_drop_down"
						>
							<q-list dense>
								<q-item clickable v-close-popup @click="markAsPaid(props.row)">
									<q-item-section avatar><q-icon name="check_circle" color="green" /></q-item-section>
									<q-item-section>Quitar (Todas)</q-item-section>
								</q-item>

								<q-item clickable v-close-popup @click="cancelReceive(props.row)">
									<q-item-section avatar><q-icon name="cancel" color="orange" /></q-item-section>
									<q-item-section>Cancelar (Todas)</q-item-section>
								</q-item>

								<q-item clickable v-close-popup @click="generateBoleto(props.row)">
									<q-item-section avatar><q-icon name="receipt_long" color="blue" /></q-item-section>
									<q-item-section>Gerar Boleto</q-item-section>
								</q-item>

								<q-item clickable v-close-popup @click="viewHistory(props.row)">
									<q-item-section avatar><q-icon name="history" color="grey" /></q-item-section>
									<q-item-section>Histórico</q-item-section>
								</q-item>
							</q-list>
						</q-btn-dropdown>
					</q-td>
				</q-tr>
			</template>

        </q-table>
        <div
            v-if="showPayClosing"
            class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-10 backdrop-blur-sm"
        >

            <div class="bg-white border border-black rounded-xl">
                <RegisterPay 
                    @close="closeRegister($event)"
                    :width-screen="widthScreen"
                    :action="'register'"
                    :to-pay-document="0"
                    :readonly="true"
                />
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios";
    import { ref, onMounted, computed } from "vue";
    import { QTableColumn, useQuasar, LocalStorage } from "quasar";
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    import LoandingPage from "src/components/Loanding/LoandingPage.vue";
    import RegisterPay from "src/components/Register/Financial/RegisterPay.vue";
    
    dayjs.extend(isBetween);

    const $q = useQuasar();
    const today = dayjs();
    const cashs = ref<IPayBody[]>([]);
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");
    const painelColor = LocalStorage.getItem("painelColor");

    let startDate = today.startOf('month').format('YYYY-MM-DD');
    let endDate = today.endOf('month').format('YYYY-MM-DD');
    let showPage = ref<boolean>(false);
    let showPayClosing = ref<boolean>(false);
    let widthScreen = ref<number>(0);
    let selectOperation = ref<string>('');   
    let selectReadonly = ref<boolean>(false);
    let selectedToPayDocument = ref<number>(0);

    const columns: QTableColumn[] = [
        { name: 'document', label: 'Documento', field: 'document', align: 'left' },
        { name: 'description', label: 'Descrição', field: 'description', align: 'left' },
        { name: 'installmentAmount', label: 'Qtde Parcela', field: 'installmentAmount', align: 'center' },
        { name: 'installmentNumber', label: 'Nº Parcela', field: 'installmentNumber', align: 'center' },
        { name: 'installmentValue', label: 'Valor Bruto', field: row => `R$ ${row.installmentValue.toFixed(2)}`, align: 'right' },
        { name: 'installmentPaid', label: 'Valor Líquido', field: row => `R$ ${row.installmentPaid.toFixed(2)}`, align: 'right', format: (val) => String(val).replace('.', ',') }, 
        { name: 'name', label: 'Cliente', field: 'name', align: 'left' },
        { name: 'dueDate', label: 'Data Vencimento', field: 'dueDate', align: 'center' },
        { name: 'especie', label: 'Espécie', field: row => row.especie.toUpperCase(), align: 'center' },
        { name: 'status', label: 'Status', field: row => row.status.toUpperCase(), align: 'center' },
        { name: 'actions', label: 'Ações', field: 'actions', align: 'center' }
	];

    const totalQuitadas = computed(() => {
        let total;
        const paidOffs = cashs.value.filter(p => p.paidOff === true);
        const totalPaid = paidOffs.map(p => p.amountPaid);
        total += totalPaid;
        return total;

    });

    const totalVencidas = computed(() => {

    });

    const totalEmAberto = computed(() => {

    });
    
    const getRegister = async() =>
    {
        const response = await api.get(`ecommerce/pay/all/${issuerID.value}`);
        cashs.value = response.data.data;
    };

    const manageClick = (receiveDocument: number, operation: string, readonly: boolean) => {
		selectOperation.value = operation;
		selectReadonly.value = readonly;

		console.log('Passando: ', receiveDocument);

		if (operation === "register") {
			
			selectedToPayDocument.value = 0;
		} else {
			selectedToPayDocument.value = receiveDocument;
		}
		
		showPayClosing.value = true;
	};

    const closeRegister = (event) =>
    { 
        showPayClosing.value = event;

    };

    const markAsPaid = (row) => {};

	const cancelReceive = (row) => {};

	const generateBoleto = (row) => {};

	const viewHistory = (row) => {};

    const getColorToPay = (row) => {
		if (row.status === "cancelada") return "bg-orange-300 text-white";
		if (row.paid && isLate(row.dueDate)) return "bg-red-400 text-white";
		if (row.paid) return "bg-green-400 text-white";
		if (!row.paid && isLate(row.dueDate)) return "bg-red-300 text-white";
		return "";
	};

    const getStatusBadge = (row) => {
        const isPaid = row.paid;
		const isLatePayment = isPaid && isLate(row.dueDate);
		const isVencida = !isPaid && isLate(row.dueDate);
		const isCancelada = row.status === "cancelada";

		if (isCancelada) return { label: "Cancelada", color: "orange", icon: "cancel" };
		if (isLatePayment) return { label: "Pago com atraso", color: "red", icon: "close" };
		if (isPaid) return { label: "Pago", color: "green", icon: "done" };
		if (isVencida) return { label: "Vencida", color: "red", icon: "close" };
		return { label: "Em aberto", color: "grey", icon: "hourglass_empty" };

    };

    const isLate = (date) => {
		return dayjs().isAfter(dayjs(date), "day");
	};

    onMounted(() => {
        getRegister();
        widthScreen.value = screen.width;

    });

</script>

<style scoped>
    .container {
        max-width: 85%;
        width: 100%;
        height: 90vh;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background-color: #f3f4f6;
    }

    tbody tr:hover {
        background-color: #f9fafb;
    }

    th, td {
        padding: 0.75rem;
        text-align: left;
    }

    th {
        font-weight: bold;
        text-transform: uppercase;
    }

    button {
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #4b5563;
    }

    @media (max-width: 768px) {
        table {
            font-size: 0.875rem;
        }

        th, td {
            padding: 0.5rem;
        }
    }
</style>