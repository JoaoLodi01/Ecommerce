<template>
	<div v-if="!showPage">
		<LoandingPage
			@show-page="showPage = $event"
			text="Carregando registros do receber ..."
		/>
	</div>

	<div
		v-if="showPage"
		class="mt-10 mb-5 p-6 bg-white rounded-lg shadow-lg mx-auto w-[90%] max-w-[1400px]"
	>
		<div class="flex justify-between items-center mb-6">
			<h1 class="text-2xl font-semibold">Receber</h1>
			<div class="flex space-x-4">
				<q-btn
					class="p-2 rounded-lg"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
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
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					label="Relatórios"
				/>

				<q-btn
					class="p-2 rounded-lg"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					@click="manageClick(0, 'register', false)"
					label="Cadastrar"
				/>
			</div>
		</div>

		<q-table
			:rows="receives"
			:columns="columns"
			row-key="receiveCod"
			flat
			bordered
			class="q-mt-md shadow-lg rounded-lg"
		>
			<template v-slot:header="props">
				<q-tr :props="props" :style="`background-color: ${painelColor}; color: white;`">
					<q-th v-for="col in props.cols" :key="col.name" :props="props" :class="`text-${col.align}`">
						{{ col.label }}
					</q-th>
				</q-tr>
			</template>

			<template v-slot:body="props">
				<q-tr :props="props" :class="getColorReceive(props.row)">
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
							text-color="white"
							class="text-xs"
							outline
							:label="getStatusBadge(props.row).label"
							:icon="getStatusBadge(props.row).icon"
						/>
					</q-td>

					<q-td key="actions" :props="props" class="text-center">
						<q-btn
							@click="manageClick(props.row.receiveCod, 'update', false)"
							icon="edit"
							color="green"
							size="sm"
							class="q-mr-xs"
						/>
						<q-btn
							@click="manageClick(props.row.receiveCod, 'view', true)"
							icon="visibility"
							color="blue"
							size="sm"
							class="q-mr-xs"
						/>
					</q-td>
				</q-tr>
			</template>
		</q-table>

		<div
			v-if="showReceiveClosing"
			class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm"
		>
			<div class="bg-white border border-gray-400 rounded-xl">
				<RegisterReceive
					:action="selectOperation"
					:readonly="selectReadonly"
					@close="closeRegister"
					:widthScreen="widthScreen"
					:receiveCod="selectedReceiveCod"
				/>
			</div>
		</div>
	</div>
</template>

<script setup lang="ts">
import dayjs from "dayjs";
import isBetween from "dayjs/plugin/isBetween";
import camelcaseKeys from "camelcase-keys";
import { ref, onMounted } from "vue";
import { QTableColumn, useQuasar } from "quasar";
import { LocalStorage } from "quasar";
import { api } from "src/boot/axios";
import LoandingPage from "src/components/Loanding/LoandingPage.vue";
import RegisterReceive from "src/components/Register/Financial/RegisterReceive.vue";

dayjs.extend(isBetween);

const $q = useQuasar();

const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
const textColor = ref<string>(LocalStorage.getItem("textColor"));
const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
const painelColor = ref<string>(LocalStorage.getItem("painelColor"));

const receives = ref([]);
const selectedRegister = ref([]);
const selectedReceiveCod = ref(0);
const selectOperation = ref("");
const selectReadonly = ref(false);
const showReceiveClosing = ref(false);
const showPage = ref(false);
const widthScreen = ref(window.innerWidth);

const columns: QTableColumn[] = [
		{ name: 'document', label: 'Documento', field: 'document', align: 'left' },
		{ name: 'description', label: 'Descrição', field: 'description', align: 'left' },
		{ name: 'installmentAmount', label: 'Qtde Parcela', field: 'installmentAmount', align: 'center' },
		{ name: 'installmentNumber', label: 'Nº Parcela', field: 'installmentNumber', align: 'center' },
		{ name: 'installmentValue', label: 'Valor Bruto', field: row => `R$ ${row.installmentValue.toFixed(2)}`, align: 'right' },
		{ name: 'installmentPaid', label: 'Valor Líquido', field: row => `R$ ${row.installmentPaid.toFixed(2)}`, align: 'right' },
		{ name: 'name', label: 'Cliente', field: 'name', align: 'left' },
		{ name: 'dueDate', label: 'Data Vencimento', field: 'dueDate', align: 'center' },
		{ name: 'especie', label: 'Espécie', field: row => row.especie.toUpperCase(), align: 'center' },
		{ name: 'status', label: 'Status', field: row => row.status.toUpperCase(), align: 'center' },
		{ name: 'actions', label: 'Ações', field: 'actions', align: 'center' }
];

const getStatusBadge = (row) => {
	const isPaid = row.paid;
	const isLatePayment = isPaid && isLate(row.dueDate);
	const isVencida = !isPaid && isLate(row.dueDate);
	const isCancelada = row.status === "cancelada";

	if (isCancelada) return { label: "Cancelada", color: "orange", icon: "cancel" };
	if (isLatePayment) return { label: "Pago com atraso", color: "red", icon: "close" };
	if (isPaid) return { label: "Pago", color: "green", icon: "done" };
	if (isVencida) return { label: "Vencida", color: "red", icon: "close" };
	return { label: "Em aberto", color: "gray", icon: "hourglass_empty" };
};

const isLate = (date) => {
	return dayjs().isAfter(dayjs(date), "day");
};

const getColorReceive = (row) => {
	if (row.status === "cancelada") return "bg-orange-300 text-white";
	if (row.paid && isLate(row.dueDate)) return "bg-red-400 text-white";
	if (row.paid) return "bg-green-400 text-white";
	if (!row.paid && isLate(row.dueDate)) return "bg-red-300 text-white";
	return "";
};

const fetchReceives = async () => {
	try {
		const response = await api.get(`ecommerce/receive/all/${issuerID.value}`);
		const camelCaseData = camelcaseKeys(response.data, { deep: true });
		receives.value = camelCaseData;
		showPage.value = true;
	} catch (error) {
		$q.notify({
			type: "negative",
			message: "Erro ao carregar registros de receber.",
		});
	}
};

onMounted(() => {
	fetchReceives();
});

const manageClick = (receiveCod, operation, readonly) => {
	selectOperation.value = operation;
	selectReadonly.value = readonly;

	if (operation === "register") {
		selectedRegister.value = [];
		selectedReceiveCod.value = 0;
	} else {
		const found = receives.value.find((r) => r.receiveCod === receiveCod);
		if (found) {
			selectedRegister.value = found.parcels || [];
			selectedReceiveCod.value = receiveCod;
		} else {
			selectedRegister.value = [];
			selectedReceiveCod.value = 0;
		}
	}
	showReceiveClosing.value = true;
};

const closeRegister = () => {
	showReceiveClosing.value = false;
	selectedRegister.value = [];
	selectedReceiveCod.value = 0;
	fetchReceives();
};
</script>

