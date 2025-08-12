<template>
	<div v-if="!showPage">
		<LoandingPage
			@show-page="showPage = $event"
			text="Carregando registros do receber ..."
		/>
	</div>

	<div v-if="showPage" class="mt-10 mb-5 p-6 bg-white rounded-lg shadow-lg mx-auto w-[90%] max-w-[1400px]">

		<div class="flex justify-between items-center mb-6">
			<h1 class="text-2xl font-semibold">Receber</h1>
			<div class="flex space-x-4">
				<q-btn
					class="p-2 rounded-lg hover:opacity-80"
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
					class="p-2 rounded-lg hover:opacity-80"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					label="Relatórios"
				/>

				<q-btn
					class="p-2 rounded-lg hover:opacity-80"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					@click="manageClick('0', 'register', false)"
					label="Cadastrar"
				/>
			</div>
		</div>

		<div class="filterDate flex  gap-4 items-end mb-6 p-3 border border-gray-300 rounded-lg w-full md:w-max">
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
					class="h-10 hover:opacity-80"
					:label="getDateFilter"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					flat
					dropdown-icon="arrow_drop_down">

					<q-list dense>
						<q-item
							v-for="option in dateFilterOptions"
							:key="option.value"
							clickable
							v-close-popup
							@click="dateFilterField = option.value">
								<q-item-section>
									{{ option.label }}
								</q-item-section>
						</q-item>
					</q-list>
				</q-btn-dropdown>

				<q-btn-dropdown
					class="h-10 hover:opacity-80"
					:label="getStatusLabel"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					flat
					dropdown-icon="arrow_drop_down">

					<q-list dense>
						<q-item
							v-for="option in statusFilterOptions"
							:key="option.value"
							clickable
							v-close-popup
							@click="statusFilterField = option.value">
								<q-item-section>
									{{ option.label }}
								</q-item-section>
						</q-item>
					</q-list>
				</q-btn-dropdown>

				<q-btn
					class="transition text-white h-10 hover:opacity-80"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					label="Limpar"
					@click="clearFilters"
				/>

				<q-btn
					class="transition text-white h-10 hover:opacity-80"
					:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
					label="Filtrar"
					@click="applyFilters"
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
					<div class="bg-green-600 h-3 w-3 rounded-full"></div>
					<span>Quitadas</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-blue-600 h-3 w-3 rounded-full"></div>
					<span>Quitada com atraso</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-orange-600 h-3 w-3 rounded-full"></div>
					<span>Canceladas</span>
				</div>

				<div class="flex items-center gap-2 text-xs">
					<div class="bg-red-600 h-3 w-3 rounded-full"></div>
					<span>Atrasadas</span>
				</div>
			</div>

			<!-- Totalizadores -->
			<div class="flex gap-4">
				<span class="border rounded px-3 py-1 bg-green-200 text-green-900">
					<q-icon name="check_circle" color="green-700" class="mr-2 mb-1" />
					Recebidas: {{ formatCurrency(totalQuitadas) }}
				</span>

				<span class="border rounded px-3 py-1 bg-yellow-200 text-yellow-900">
					<q-icon name="hourglass_empty" color="orange" class="mr-2 mb-1" />
					Pendentes: {{ formatCurrency(totalEmAberto) }}
				</span>

				<span class="border rounded px-3 py-1 bg-red-300 text-red-900">
					<q-icon name="warning" color="red" class="mr-2 mb-1" />
					Atrasadas ( + juros ): {{ formatCurrency(totalVencidas) }}
				</span>
			</div>
		</div>

		<q-table
			:rows="receives"
			:columns="columns"
			row-key="document"
			selection="multiple"
            v-model:selected="selectedRows"
            :pagination="{ rowsPerPage: 10}"
			flat
			:loading="loading"
			dense
			
		>
			
			<template v-slot:body="props">
				<q-tr :props="props" :class="getColorReceive(props.row)">
					<q-td key="check" class="text-center">
						<q-checkbox
							:model-value="rowSelected(props.row)"
							@update:model-value="val => toggleRowSelection(props.row, val)"
						/>
					</q-td>

					<q-td
						v-for="col in props.cols"
						:key="col?.name"
						:props="props"
						class="text-center"
					>
						<template v-if="col.name === 'status'">
							<q-badge
								v-bind="getStatusBadge(props.row)"
								class="text-xs rounded"
								outlined
							/>
						</template>

						<template v-else>
							{{ typeof col.field === 'function' ? col.field(props.row) : props.row[col.field] }}
						</template>
					</q-td>

					<q-td key="actions" class="text-center">
						<q-btn
							@click="manageClick(props.row.receiveDocument, 'update', false)"
							icon="edit"
							color="green"
							size="sm"
							class="q-mr-xs "
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
							:style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
							flat
							dropdown-icon="arrow_drop_down"
						>
							<q-list dense>
								<q-item clickable v-close-popup @click="markAsPaid(props.row)">
									<q-item-section avatar>
										<q-icon name="check_circle" color="green" />
									</q-item-section>
									<q-item-section>Quitar (Todas)</q-item-section>
								</q-item>
								<q-item clickable v-close-popup @click="cancelReceive(props.row)">
									<q-item-section avatar>
										<q-icon name="cancel" color="orange" />
									</q-item-section>
									<q-item-section>Cancelar (Todas)</q-item-section>
								</q-item>
								<q-item clickable v-close-popup @click="generateBoleto(props.row)">
									<q-item-section avatar>
										<q-icon name="receipt_long" color="blue" />
									</q-item-section>
									<q-item-section>Visualizar</q-item-section>
								</q-item>
								<q-item clickable v-close-popup @click="viewHistory(props.row)">
									<q-item-section avatar>
										<q-icon name="history" color="grey" />
									</q-item-section>
									<q-item-section>Histórico</q-item-section>
								</q-item>
							</q-list>
						</q-btn-dropdown>
					</q-td>
				</q-tr>
			</template>
		</q-table>

		<div v-if="showReceiveClosing" class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
			
			<div class="bg-white border border-gray-400 rounded-xl">
				<RegisterReceive
					:action="selectOperation"
					:readonly="selectReadonly"
					@close="closeRegister"
					:widthScreen="widthScreen"
					:receiveDocument="selectedReceiveDocument"
				/>
			</div>
		</div>
	</div>
</template>

<script setup lang="ts">
	//#region AMBIENTE

	import dayjs from "dayjs";
	import { ref, onMounted } from "vue";
	import { api } from "src/boot/axios";
	import { LocalStorage } from "quasar";
	import camelcaseKeys from "camelcase-keys";
	import { computed } from "@vue/reactivity";
	import isBetween from "dayjs/plugin/isBetween";
	import { QTableColumn, useQuasar } from "quasar";
	import LoandingPage from "src/components/Loanding/LoandingPage.vue";
	import RegisterReceive from "src/components/Register/Financial/RegisterReceive.vue";

	dayjs.extend(isBetween);

	const today = dayjs();
	const $q = useQuasar();
	const receives = ref([]);
	const loading = ref(false);
	const showPage = ref(false);
	const selectOperation = ref("");
	const originalReceives = ref([]);
	const selectedRegister = ref([]);
	const selectReadonly = ref(false);
	const selectedRows = ref<any[]>([]);
	const showReceiveClosing = ref(false);
	const widthScreen = ref(window.innerWidth);
	const selectedReceiveDocument = ref<string>('0');
	const statusFilterField = ref<StatusFilterValue>('all');
	const dateFilterField = ref<DateFilterValue>('createdAt');
	const endDate = ref(today.endOf('month').format('YYYY-MM-DD'));
	const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
	const textColor = ref<string>(LocalStorage.getItem("textColor"));
	const startDate = ref(today.startOf('month').format('YYYY-MM-DD'));
	const painelColor = ref<string>(LocalStorage.getItem("painelColor"));
	const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));

	type DateFilterValue = 'createdAt' | 'dueDate' | 'datePaid';
	type StatusFilterValue = 'all' | 'open' | 'paid' | 'overdue' | 'canceled';
	//#endregion

	//#region Q-TABLE
	const columns: QTableColumn[] = [
		{ name: 'document', label: 'Documento', field: 'document', align: 'center' },
		{ name: 'description', label: 'Descrição', field: 'description', align: 'left' },
		{ name: 'installmentAmount', label: 'Qtde. Parcelas', field: 'installmentAmount', align: 'center' },
		{ name: 'installmentValue', label: 'Valor Bruto', field: row => formatCurrency(row.installmentValue) , align: 'center' },
		{ name: 'installmentPaid', label: 'Valor Líquido', field: row => formatCurrency(row.installmentPaid), align: 'center' },
		{ name: 'name', label: 'Cliente', field: 'name', align: 'left' },
		{ name: 'dueDate', label: 'Data Vencimento', field: 'dueDate', align: 'center' },
		{ name: 'especie', label: 'Espécie', field: row => row.especie.toUpperCase(), align: 'center' },
		{ name: 'status', label: 'Status', field: 'status', align: 'center' },
		{ name: 'actions', label: 'Ações', field: 'actions', align: 'center', sortable: false }
	];

	const getStatusBadge = (row) => {
		const isPaid = row.paid;
		const isLatePayment = isPaid && isLate(row.dueDate);
		const isVencida = !isPaid && isLate(row.dueDate);
		const isCancelada = row.status === "cancelada";

		if (isCancelada) return { label: "Cancelada", color: "orange", textColor: 'white'  };
		if (isLatePayment) return { label: "Pago com atraso", color: "blue", textColor: 'white' };
		if (isPaid) return { label: "Pago", color: "green", textColor: 'white' };
		if (isVencida) return { label: "Vencida", color: "red", textColor: 'white' };

		return { label: "Em aberto", color: "grey" };
	};

	const isLate = (date: string) => {
		return dayjs().isAfter(dayjs(date), "day");
	};

	const toggleAllSelection = (val: boolean) => {
		selectedRows.value = val ? receives.value.slice() : [];
	};

	const selectedDocsSet = computed(() => new Set(selectedRows.value.map(r => r.document)));

	const rowSelected = (row) => {
		return selectedDocsSet.value.has(row.document);
	};

	const toggleRowSelection = (row, isSelected) => {
		if (isSelected) {
			selectedRows.value.push(row);
		} else {
			selectedRows.value = selectedRows.value.filter(r => r.document !== row.document);
		}
	}

	const getColorReceive = (row) => {
		if (row.status === "cancelada") return "text-orange-600";
		if (row.paid) return isLate(row.dueDate) ? "text-blue-600" : "text-green-600";
		return isLate(row.dueDate) ? "text-red-600" : "text-gray-800";
	};

	const getReceives = async () => {
		loading.value = true;
		try {
			const res = await api.get(`/ecommerce/receive/all/${issuerID.value}`);
			originalReceives.value = camelcaseKeys(res.data.data, { deep: true });
			applyFilters();
			showPage.value = true;
		} catch (error) {
			$q.notify({ color: 'red', message: 'Erro ao carregar dados' });
		} finally {
			loading.value = false;
		}
	};

	//#endregion

	//#region GERAIS
	const manageClick = (receiveDocument: string, operation: string, readonly: boolean) => {
		selectOperation.value = operation;
		selectReadonly.value = readonly;

		console.log('Passando: ', receiveDocument);

		if (operation === "register") {
			selectedRegister.value = [];
			selectedReceiveDocument.value = '0';
		} else {
			selectedReceiveDocument.value = receiveDocument;
		}

		showReceiveClosing.value = true;
	};

	const closeRegister = () => {
		showReceiveClosing.value = false;
		selectedRegister.value = [];
		selectedReceiveDocument.value = '0';
		getReceives();
	};

	onMounted(() => {
		getReceives();
		console.log('Documento: ', selectedReceiveDocument.value);
	});
	//#endregion

	//#region OPTIONS ROWS

	const markAsPaid = async (row) => {
		$q.dialog({
			title: 'Confirmação',
			message: `Realmente deseja quitar o documento ${row.document}?`,
			cancel: true,
			persistent: true
		}).onOk(async () => {
			try {
				loading.value = true;
				await api.put(`/ecommerce/receive/markPaid/$(row.receiveDocument)`);

				$q.notify({
					color: 'green',
					message: 'Recebimento quitado com sucesso!',
				});

				await getReceives();
			} catch (error) {
				$q.notify({ 
					color: 'red',
					message: 'Erro ao marcar como quitado.'
				});
			} finally {
				loading.value = false;
			}
		});
	};

	const cancelReceive = async (row) => {
		$q.dialog({
			title: 'Cancelar Recebimento',
			message: `Deseja realmente cancelar o documento ${row.document}?`,
			cancel: true,
			persistent: true
		}).onOk(async () => {
			try {
				loading.value = true;
				await api.put(`/ecommerce/receive/cancel/${row.receiveDocument}`);

				$q.notify({
					color: 'red',
					message: 'Recebimento cancelado com sucesso.'
				});

				await getReceives();

			} catch (error) {
				$q.notify({
					color: 'red',
					message: 'Erro ao cancelar recebimento.'
				});

			} finally {
				loading.value = false;
			}
		});
	};

	const generateBoleto = (row) => {};

	const viewHistory = (row) => {};

	//#endregion

	//#region FILTROS
	const dateFilterOptions: { label: string; value: DateFilterValue }[] = [
		{ label: 'Data de Cadastro', value: 'createdAt' },
		{ label: 'Data de Pagamento', value: 'datePaid' },
		{ label: 'Data de Vencimento', value: 'dueDate' },
	];

	const statusFilterOptions: { label: string; value: StatusFilterValue }[] = [
		{ label: 'Todos', value: 'all' },
		{ label: 'Em Aberto', value: 'open' },
		{ label: 'Quitadas', value: 'paid' },
		{ label: 'Vencidas', value: 'overdue' },
		{ label: 'Canceladas', value: 'canceled' }
	];

	const getDateFilter = computed(() => {
		const selected = dateFilterOptions.find(opt => opt.value === dateFilterField.value);
		return selected ? selected.label : 'Selecionar Data';
	});

	const getStatusLabel = computed(() => {
		const selected = statusFilterOptions.find(opt => opt.value === statusFilterField.value);
		return selected ? selected.label : 'Selecionar Status';
	});

	const applyFilters = () => {
		let filtered = originalReceives.value;

		// Filtro por data
		if (startDate.value && endDate.value) {
			const start = dayjs(startDate.value);
			const end = dayjs(endDate.value);

			filtered = filtered.filter(receive => {
				const filterDate = dayjs(receive[dateFilterField.value]);
				return filterDate.isValid() && filterDate.isBetween(start, end, null, '[]');
			});
		}

		// Filtro por status
		if (statusFilterField.value !== 'all') {
			filtered = filtered.filter(receive => {
				switch (statusFilterField.value) {
					case 'paid':
						return receive.paid === true;

					case 'overdue':
						return !receive.paid && isLate(receive.dueDate);

					case 'open':
						return !receive.paid && !isLate(receive.dueDate);

					case 'canceled':
						return receive.status === 'cancelada';

					default:
						return true;
				}
			});
		}
		
		receives.value = filtered;
	};

	const clearFilters = () => {
		startDate.value = '';
		endDate.value = '';
		dateFilterField.value = 'dueDate';
		statusFilterField.value = 'all';
		receives.value = originalReceives.value;
	};
	//#endregion

	//#region TOTALIZADORES
	const totalQuitadas = computed(() => 
			receives.value.reduce((acc, r) => acc + (r.paid ? Number(r.installmentValue) : 0), 0)
		);

		const totalVencidas = computed(() => 
			receives.value.reduce((acc, r) => {
				const vencida = !r.paid && dayjs(r.dueDate).isBefore(dayjs(), 'day');
				return acc + (vencida ? r.installmentValue : 0);
			}, 0)
		);

		const totalEmAberto = computed(() => {
			const total = receives.value
				.filter(inst => !inst.paid && !isLateDate(inst.dueDate))
				.reduce((sum, inst) => sum + Number(inst.installmentValue || 0), 0);

			return total.toFixed(2);
		});

		const isLateDate = (dueDate: string): boolean => {
			return dayjs(dueDate).isBefore(dayjs(), 'day');
		};
		
		const formatCurrency = (value: number) =>
			new Intl.NumberFormat("pt-BR", {
				style: "currency",
				currency: "BRL"
		}).format(value || 0);
	//#endregion
</script>